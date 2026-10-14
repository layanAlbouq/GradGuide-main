import os
import shutil
from fastapi import APIRouter, Depends, File, HTTPException, UploadFile, status
from sqlalchemy.orm import Session
from pypdf import PdfReader
from app.database import get_db
from .models import Resume, User
from app.auth import get_current_user

router = APIRouter(prefix="/cv", tags=["CV Management"])

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@router.post("/upload")
def upload_cv(
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    if not file.filename.endswith(".pdf"):
        raise HTTPException(
            status_code=400, detail="Only PDF files are allowed."
        )

    file_path = os.path.join(UPLOAD_DIR, f"{current_user.user_id}_{file.filename}")
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    extracted_text = ""
    try:
        reader = PdfReader(file_path)
        for page in reader.pages:
            text = page.extract_text()
            if text:
                extracted_text += text + "\n"
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Failed to extract text from PDF: {str(e)}"
        )

    db_resume = Resume(
        user_id=current_user.user_id,
        file_name=file.filename,
        cv_file_path=file_path,
        raw_text=extracted_text,
    )
    db.add(db_resume)
    db.commit()
    db.refresh(db_resume)

    return {
        "message": "CV uploaded and processed successfully",
        "resume_id": db_resume.resume_id,
        "file_name": db_resume.file_name,
        "extracted_text_preview": extracted_text[:300],
    }