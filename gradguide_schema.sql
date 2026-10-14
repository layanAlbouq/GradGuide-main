--
-- PostgreSQL database dump
--

\restrict IJzgIm8htTKSMBh0IxE32T65AcykqZGN0uJ5R1vMkBGwUk4luDmdK8Qxk0f58eU

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-07 08:32:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 98397)
-- Name: analysis_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analysis_results (
    analysis_id integer NOT NULL,
    resume_id integer NOT NULL,
    matched_profile_id integer NOT NULL,
    similarity_score numeric(5,4),
    analysis_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_similarity_score CHECK (((similarity_score >= (0)::numeric) AND (similarity_score <= (1)::numeric)))
);


ALTER TABLE public.analysis_results OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 98396)
-- Name: analysis_results_analysis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analysis_results_analysis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analysis_results_analysis_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 229
-- Name: analysis_results_analysis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analysis_results_analysis_id_seq OWNED BY public.analysis_results.analysis_id;


--
-- TOC entry 224 (class 1259 OID 98341)
-- Name: career_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_profiles (
    profile_id integer NOT NULL,
    target_career character varying(100) NOT NULL,
    experience_level character varying(50),
    experience_years integer,
    education_level character varying(100),
    major character varying(150),
    work_experience text,
    raw_text text,
    certifications text,
    projects text
);


ALTER TABLE public.career_profiles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 98340)
-- Name: career_profiles_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.career_profiles_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.career_profiles_profile_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 223
-- Name: career_profiles_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.career_profiles_profile_id_seq OWNED BY public.career_profiles.profile_id;


--
-- TOC entry 228 (class 1259 OID 98379)
-- Name: profile_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile_skills (
    profile_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.profile_skills OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 98441)
-- Name: recommendations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendations (
    recommendation_id integer NOT NULL,
    analysis_id integer NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(255) NOT NULL,
    provider_platform character varying(150),
    description text,
    url character varying(500),
    CONSTRAINT chk_recommendation_type CHECK (((type)::text = ANY ((ARRAY['Course'::character varying, 'Certification'::character varying, 'Project'::character varying, 'Training'::character varying])::text[])))
);


ALTER TABLE public.recommendations OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 98440)
-- Name: recommendations_recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendations_recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendations_recommendation_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 233
-- Name: recommendations_recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendations_recommendation_id_seq OWNED BY public.recommendations.recommendation_id;


--
-- TOC entry 227 (class 1259 OID 98362)
-- Name: resume_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resume_skills (
    resume_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.resume_skills OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 98322)
-- Name: resumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumes (
    resume_id integer NOT NULL,
    user_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    cv_file_path character varying(500) NOT NULL,
    raw_text text,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resumes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 98321)
-- Name: resumes_resume_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resumes_resume_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resumes_resume_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 221
-- Name: resumes_resume_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resumes_resume_id_seq OWNED BY public.resumes.resume_id;


--
-- TOC entry 232 (class 1259 OID 98419)
-- Name: skill_gaps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_gaps (
    gap_id integer NOT NULL,
    analysis_id integer NOT NULL,
    missing_skill_id integer NOT NULL
);


ALTER TABLE public.skill_gaps OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 98418)
-- Name: skill_gaps_gap_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skill_gaps_gap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skill_gaps_gap_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 231
-- Name: skill_gaps_gap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skill_gaps_gap_id_seq OWNED BY public.skill_gaps.gap_id;


--
-- TOC entry 226 (class 1259 OID 98352)
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    skill_name character varying(150) NOT NULL,
    category character varying(100)
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 98351)
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_skill_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 225
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- TOC entry 220 (class 1259 OID 98306)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    major character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 98305)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4900 (class 2604 OID 98400)
-- Name: analysis_results analysis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_results ALTER COLUMN analysis_id SET DEFAULT nextval('public.analysis_results_analysis_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 98344)
-- Name: career_profiles profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_profiles ALTER COLUMN profile_id SET DEFAULT nextval('public.career_profiles_profile_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 98444)
-- Name: recommendations recommendation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN recommendation_id SET DEFAULT nextval('public.recommendations_recommendation_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 98325)
-- Name: resumes resume_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes ALTER COLUMN resume_id SET DEFAULT nextval('public.resumes_resume_id_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 98422)
-- Name: skill_gaps gap_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gaps ALTER COLUMN gap_id SET DEFAULT nextval('public.skill_gaps_gap_id_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 98355)
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 98309)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4923 (class 2606 OID 98407)
-- Name: analysis_results analysis_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_results
    ADD CONSTRAINT analysis_results_pkey PRIMARY KEY (analysis_id);


--
-- TOC entry 4913 (class 2606 OID 98350)
-- Name: career_profiles career_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_profiles
    ADD CONSTRAINT career_profiles_pkey PRIMARY KEY (profile_id);


--
-- TOC entry 4921 (class 2606 OID 98385)
-- Name: profile_skills profile_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile_skills
    ADD CONSTRAINT profile_skills_pkey PRIMARY KEY (profile_id, skill_id);


--
-- TOC entry 4929 (class 2606 OID 98453)
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (recommendation_id);


--
-- TOC entry 4919 (class 2606 OID 98368)
-- Name: resume_skills resume_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_skills
    ADD CONSTRAINT resume_skills_pkey PRIMARY KEY (resume_id, skill_id);


--
-- TOC entry 4911 (class 2606 OID 98334)
-- Name: resumes resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (resume_id);


--
-- TOC entry 4925 (class 2606 OID 98427)
-- Name: skill_gaps skill_gaps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gaps
    ADD CONSTRAINT skill_gaps_pkey PRIMARY KEY (gap_id);


--
-- TOC entry 4915 (class 2606 OID 98359)
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- TOC entry 4917 (class 2606 OID 98361)
-- Name: skills skills_skill_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_skill_name_key UNIQUE (skill_name);


--
-- TOC entry 4927 (class 2606 OID 98429)
-- Name: skill_gaps uq_analysis_missing_skill; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gaps
    ADD CONSTRAINT uq_analysis_missing_skill UNIQUE (analysis_id, missing_skill_id);


--
-- TOC entry 4907 (class 2606 OID 98320)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4909 (class 2606 OID 98318)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4935 (class 2606 OID 98413)
-- Name: analysis_results fk_analysis_profile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_results
    ADD CONSTRAINT fk_analysis_profile FOREIGN KEY (matched_profile_id) REFERENCES public.career_profiles(profile_id) ON DELETE CASCADE;


--
-- TOC entry 4936 (class 2606 OID 98408)
-- Name: analysis_results fk_analysis_resume; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_results
    ADD CONSTRAINT fk_analysis_resume FOREIGN KEY (resume_id) REFERENCES public.resumes(resume_id) ON DELETE CASCADE;


--
-- TOC entry 4933 (class 2606 OID 98386)
-- Name: profile_skills fk_profile_skills_profile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile_skills
    ADD CONSTRAINT fk_profile_skills_profile FOREIGN KEY (profile_id) REFERENCES public.career_profiles(profile_id) ON DELETE CASCADE;


--
-- TOC entry 4934 (class 2606 OID 98391)
-- Name: profile_skills fk_profile_skills_skill; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile_skills
    ADD CONSTRAINT fk_profile_skills_skill FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 98454)
-- Name: recommendations fk_recommendation_analysis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT fk_recommendation_analysis FOREIGN KEY (analysis_id) REFERENCES public.analysis_results(analysis_id) ON DELETE CASCADE;


--
-- TOC entry 4931 (class 2606 OID 98369)
-- Name: resume_skills fk_resume_skills_resume; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_skills
    ADD CONSTRAINT fk_resume_skills_resume FOREIGN KEY (resume_id) REFERENCES public.resumes(resume_id) ON DELETE CASCADE;


--
-- TOC entry 4932 (class 2606 OID 98374)
-- Name: resume_skills fk_resume_skills_skill; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_skills
    ADD CONSTRAINT fk_resume_skills_skill FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id) ON DELETE CASCADE;


--
-- TOC entry 4930 (class 2606 OID 98335)
-- Name: resumes fk_resume_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT fk_resume_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4937 (class 2606 OID 98430)
-- Name: skill_gaps fk_skill_gap_analysis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gaps
    ADD CONSTRAINT fk_skill_gap_analysis FOREIGN KEY (analysis_id) REFERENCES public.analysis_results(analysis_id) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 98435)
-- Name: skill_gaps fk_skill_gap_skill; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gaps
    ADD CONSTRAINT fk_skill_gap_skill FOREIGN KEY (missing_skill_id) REFERENCES public.skills(skill_id) ON DELETE CASCADE;


-- Completed on 2026-10-07 08:32:04

--
-- PostgreSQL database dump complete
--

\unrestrict IJzgIm8htTKSMBh0IxE32T65AcykqZGN0uJ5R1vMkBGwUk4luDmdK8Qxk0f58eU

