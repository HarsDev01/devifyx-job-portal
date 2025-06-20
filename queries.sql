-- ====================
-- SAMPLE DATA
-- ====================

-- Sample Users (2 seekers + 2 employers)
INSERT INTO Users (email, password_hash, user_type) VALUES
('alice@gmail.com', 'hashed_pw_1', 'seeker'),
('bob@company.com', 'hashed_pw_2', 'employer'),
('john.doe@gmail.com', 'hashed_pw_3', 'seeker'),
('hr@innovatech.com', 'hashed_pw_4', 'employer');

-- Job Seekers
INSERT INTO Job_Seekers (seeker_id, full_name, phone, location) VALUES
(1, 'Alice Smith', '1234567890', 'Delhi'),
(3, 'John Doe', '9876543210', 'Mumbai');

-- Employers
INSERT INTO Employers (employer_id, company_name, contact_person, company_website, location) VALUES
(2, 'TechCorp', 'Bob Johnson', 'http://techcorp.com', 'Bangalore'),
(4, 'InnovaTech', 'Sarah Green', 'http://innovatech.com', 'Pune');

-- Resumes
INSERT INTO Resumes (seeker_id, file_name, upload_date) VALUES
(1, 'alice_resume.pdf', '2025-06-18'),
(3, 'john_resume.docx', '2025-06-15');

-- Job Postings
INSERT INTO Job_Postings (employer_id, title, description, location, salary, skills_required, expiry_date) VALUES
(2, 'Backend Developer', 'Develop REST APIs', 'Remote', 800000.00, 'Node.js, MySQL', '2025-07-01'),
(2, 'Data Analyst', 'Analyze sales data', 'Bangalore', 600000.00, 'Python, SQL, Excel', '2025-07-05'),
(4, 'Frontend Developer', 'Work on React-based UI', 'Pune', 700000.00, 'React, JavaScript, HTML/CSS', '2025-07-10');

-- Applications
INSERT INTO Applications (job_id, seeker_id, resume_id, status) VALUES
(1, 1, 1, 'received'),
(2, 3, 2, 'shortlisted'),
(3, 1, 1, 'received');

-- Saved Jobs
INSERT INTO Saved_Jobs (seeker_id, job_id) VALUES 
(1, 2),
(3, 1),
(3, 3);

-- Notifications
INSERT INTO Notifications (user_id, message) VALUES
(1, 'Your application for Backend Developer has been received.'),
(3, 'You have been shortlisted for Data Analyst role.');

-- Audit Logs
INSERT INTO Audit_Log (action_type, description, user_id) VALUES
('Post Job', 'Posted Backend Developer job', 2),
('Update Application', 'Shortlisted John for Data Analyst', 2);

-- ====================
-- FEATURE QUERIES
-- ====================

-- 1. Search jobs by title or location
SELECT * FROM Job_Postings
WHERE title LIKE '%Developer%' OR location LIKE '%Remote%';

-- 2. Filter jobs by company name
SELECT JP.* FROM Job_Postings JP
JOIN Employers E ON JP.employer_id = E.employer_id
WHERE E.company_name LIKE '%TechCorp%';

-- 3. Filter jobs by required skills
SELECT * FROM Job_Postings
WHERE skills_required LIKE '%MySQL%';

-- 4. Employer Dashboard: View job postings and applications
SELECT JP.title, A.application_id, A.status, JS.full_name
FROM Job_Postings JP
JOIN Applications A ON JP.job_id = A.job_id
JOIN Job_Seekers JS ON A.seeker_id = JS.seeker_id
WHERE JP.employer_id = 2;

-- 5. Update application status
UPDATE Applications SET status = 'hired' WHERE application_id = 2;

-- 6. Mark expired jobs
UPDATE Job_Postings SET is_expired = TRUE
WHERE expiry_date < CURDATE();

-- 7. Show saved jobs for a job seeker
SELECT JP.* FROM Saved_Jobs SJ
JOIN Job_Postings JP ON SJ.job_id = JP.job_id
WHERE SJ.seeker_id = 3;

-- 8. Application tracking by job seeker
SELECT A.*, JP.title FROM Applications A
JOIN Job_Postings JP ON A.job_id = JP.job_id
WHERE A.seeker_id = 1;

-- 9. List of uploaded resumes by a seeker
SELECT * FROM Resumes WHERE seeker_id = 3;

-- 10. Notifications for a user
SELECT * FROM Notifications WHERE user_id = 3 ORDER BY created_at DESC;
