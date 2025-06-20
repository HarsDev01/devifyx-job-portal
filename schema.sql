-- ===========================
-- DevifyX MySQL Job Portal Assignment
-- Schema, Sample Data & Queries
-- Author: Harshit Bansal
-- ===========================

-- Drop all existing tables (if any)
DROP TABLE IF EXISTS Audit_Log, Notifications, Saved_Jobs, Applications, Job_Postings, Resumes, Employers, Job_Seekers, Users;

-- ====================
-- USER TABLES
-- ====================

-- Base Users Table (used by both job seekers and employers)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    user_type ENUM('seeker', 'employer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Job Seeker Profile Table
CREATE TABLE Job_Seekers (
    seeker_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    location VARCHAR(100),
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id)
);

-- Employer Profile Table
CREATE TABLE Employers (
    employer_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    company_website VARCHAR(255),
    location VARCHAR(100),
    FOREIGN KEY (employer_id) REFERENCES Users(user_id)
);

-- ====================
-- JOB RELATED TABLES
-- ====================

-- Resume Metadata Table
CREATE TABLE Resumes (
    resume_id INT AUTO_INCREMENT PRIMARY KEY,
    seeker_id INT,
    file_name VARCHAR(255),
    upload_date DATE,
    FOREIGN KEY (seeker_id) REFERENCES Job_Seekers(seeker_id)
);

-- Job Postings Table
CREATE TABLE Job_Postings (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT,
    title VARCHAR(100),
    description TEXT,
    location VARCHAR(100),
    salary DECIMAL(10,2),
    skills_required TEXT,
    post_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATE,
    is_expired BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (employer_id) REFERENCES Employers(employer_id)
);

-- Job Applications Table
CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    seeker_id INT,
    resume_id INT,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('received', 'shortlisted', 'rejected', 'hired') DEFAULT 'received',
    FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id),
    FOREIGN KEY (seeker_id) REFERENCES Job_Seekers(seeker_id),
    FOREIGN KEY (resume_id) REFERENCES Resumes(resume_id)
);

-- ====================
-- OPTIONAL FEATURES
-- ====================

-- Saved Jobs Table
CREATE TABLE Saved_Jobs (
    seeker_id INT,
    job_id INT,
    saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (seeker_id, job_id),
    FOREIGN KEY (seeker_id) REFERENCES Job_Seekers(seeker_id),
    FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id)
);

-- Notifications Table
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Audit Log Table
CREATE TABLE Audit_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(100),
    description TEXT,
    user_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

