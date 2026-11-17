# Lab 10 Report: MySQL + SQL - University Relational Database

**Name:** ____________   **Roll No:** ____________   **Date:** ____________

## 1. Objective
Design a relational database for a university, use keys and constraints, insert seed data,
write CRUD, JOIN, GROUP BY and aggregate queries, and export the database as SQL.

## 2. Implementation
- Database `university_portal` with six tables created in dependency order:
  `departments`, `teachers`, `students`, `courses`, `enrollments`, `attendance`.
- **Primary keys:** `id` (AUTO_INCREMENT) in every table.
- **Foreign keys (7):** teachers.department_id, students.department_id, courses.department_id,
  courses.teacher_id, enrollments.student_id, enrollments.course_id, attendance.enrollment_id.
- **Constraints:** UNIQUE (department name/code, emails, roll_no, course code,
  student+course, enrollment+date), NOT NULL, CHECK (semester 1-8, credit hours 1-6, marks 0-100),
  ENUM attendance status, ON DELETE CASCADE / SET NULL.
- **Relationships:** department 1-N students/teachers/courses; teacher 1-N courses;
  students N-M courses through `enrollments`; enrollment 1-N `attendance`.
- **Normalization:** each fact is stored once; the many-to-many link lives in `enrollments`.
- **Seed data:** 4 departments, 6 teachers, 12 students, 8 courses, 33 enrollments, 198 attendance rows.
- **Queries:** 18 reports + CRUD examples in `database/queries.sql`
  (JOIN, LEFT JOIN, GROUP BY, HAVING, aggregates, subqueries).
- **Website:** PHP + PDO site that shows the tables, relations and runs every report.

## 3. Results
Attach screenshots: table list, relations view, JOIN result, enrollment counts, attendance percentage, export.
All 18 queries run without errors; the exported SQL re-imports successfully.

## 4. Problems and Solutions
| Problem | Solution |
|---|---|
| Foreign key error when inserting | Insert parent rows first (departments before students) |
| Duplicate key error | Check UNIQUE fields such as email and roll_no |
| Courses with no students missing from counts | Use LEFT JOIN instead of INNER JOIN |
| Unknown column | Check exact column names and table aliases |

## 5. Conclusion
A normalized university database was designed, populated and queried, and exported as SQL.
