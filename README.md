

https://github.com/user-attachments/assets/a313cc68-f802-4d8c-8225-d0543784852f

# DevifyX MySQL Job Portal Assignment

**Author:** Harshit Bansal  
**Submission:** Schema + Sample Data + Queries + Video Demo

---

## 📁 Project Contents

| File         | Description |
|--------------|-------------|
| `schema.sql` | SQL script to create all tables (core + optional features) |
| `queries.sql`| SQL insertions for sample data and feature-based queries |
| `README.md`  | Project overview, usage, and highlights |

---

## 📌 Features Implemented

### ✅ Core Requirements
- User registration and authentication (`Users` table)
- Separate profiles for job seekers and employers
- Resume upload metadata (`Resumes` table)
- Employers can create, update, delete job postings
- Job seekers can apply to jobs using uploaded resumes
- Employers can manage applications via status updates
- Employer dashboard to view postings and applications
- SQL queries for search and filtering by title, location, company, and skills

### 💡 Bonus Features
- Saved jobs (`Saved_Jobs` table)
- Notifications (`Notifications` table)
- Audit logs for actions (`Audit_Log` table)
- Auto-expiry of jobs via date comparison

---

## 🧪 Sample Data
Includes:
- 2 Job Seekers and 2 Employers
- 3 Job Postings
- 3 Applications
- Multiple resume entries
- Saved jobs, notifications, and logs

All `INSERT` statements are in `queries.sql`.

---

## 🛠️ How to Use

1. **Run `schema.sql`** to create the database tables.
2. **Run `queries.sql`** to populate with demo data and test features.
3. Review query results in your MySQL client to validate behavior.

Tested on **MySQL v5.7+**.

---

## 📹 Video Demo
- A short video (under 10MB) demonstrates the schema execution and query results.
- The video file is submitted as part of this assignment.

---

Thank you for reviewing my project! ✨
