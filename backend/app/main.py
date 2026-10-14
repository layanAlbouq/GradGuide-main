from fastapi import FastAPI
from .auth import router as auth_router
from .cv import router as cv_router

app = FastAPI(
    title="GradGuide API",
    description="Backend API for GradGuide Career Path and Skill Recommendation System",
    version="1.0.0"
)

app.include_router(auth_router)

app.include_router(cv_router)

@app.get("/")
def root():
    return {"message": "GradGuide API is running"}
