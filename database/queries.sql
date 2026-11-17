-- ============================================================
-- Lab 10: University Portal - SQL queries (18 reports + CRUD)
-- Run after schema.sql:  USE university_portal;
-- Attendance % counts 'Present' and 'Late' as attended.
-- ============================================================
USE university_portal;

-- ---------- A. Basic SELECT and JOIN ----------

-- Q1. Students with their department names (INNER JOIN)  [Basic task]
SELECT s.id, s.roll_no, s.name, d.name AS department, s.semester
FROM students s
INNER JOIN departments d ON d.id = s.department_id
ORDER BY d.name, s.name;

-- Q2. Teachers with their departments
SELECT t.name AS teacher, t.designation, d.name AS department
FROM teachers t
JOIN departments d ON d.id = t.department_id
ORDER BY d.name, t.name;

-- Q3. Courses with department and teacher (LEFT JOIN keeps courses with no teacher)
SELECT c.code, c.title, c.credit_hours, d.name AS department, t.name AS teacher
FROM courses c
JOIN departments d  ON d.id = c.department_id
LEFT JOIN teachers t ON t.id = c.teacher_id
ORDER BY c.code;

-- Q4. Which student is enrolled in which course (3-table JOIN)
SELECT s.roll_no, s.name AS student, c.code, c.title, e.enrolled_on
FROM enrollments e
JOIN students s ON s.id = e.student_id
JOIN courses  c ON c.id = e.course_id
ORDER BY s.roll_no, c.code;

-- ---------- B. GROUP BY and aggregates ----------

-- Q5. Enrollment count per course (LEFT JOIN so empty courses show 0)  [Basic task]
SELECT c.code, c.title, COUNT(e.id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.code, c.title
ORDER BY enrolled_students DESC, c.code;

-- Q6. Number of students per department
SELECT d.name AS department, COUNT(s.id) AS total_students
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.id, d.name
ORDER BY total_students DESC;

-- Q7. Students taking 3 or more courses (HAVING filters groups)
SELECT s.name, COUNT(e.id) AS courses_taken
FROM students s
JOIN enrollments e ON e.student_id = s.id
GROUP BY s.id, s.name
HAVING COUNT(e.id) >= 3
ORDER BY courses_taken DESC, s.name;

-- Q8. Total credit hours per student
SELECT s.name, SUM(c.credit_hours) AS total_credit_hours
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN courses c     ON c.id = e.course_id
GROUP BY s.id, s.name
ORDER BY total_credit_hours DESC;

-- ---------- C. Attendance reports ----------

-- Q9. Overall attendance percentage by student  [Basic task]
SELECT s.roll_no, s.name,
       COUNT(a.id) AS classes_held,
       SUM(a.status IN ('Present','Late')) AS attended,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN attendance a  ON a.enrollment_id = e.id
GROUP BY s.id, s.roll_no, s.name
ORDER BY attendance_percent DESC;

-- Q10. Attendance percentage per student per course
SELECT s.name AS student, c.code AS course,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM attendance a
JOIN enrollments e ON e.id = a.enrollment_id
JOIN students s    ON s.id = e.student_id
JOIN courses c     ON c.id = e.course_id
GROUP BY s.id, s.name, c.id, c.code
ORDER BY s.name, c.code;

-- Q11. Students below 75% attendance (shortage list)
SELECT s.roll_no, s.name,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN attendance a  ON a.enrollment_id = e.id
GROUP BY s.id, s.roll_no, s.name
HAVING attendance_percent < 75
ORDER BY attendance_percent;

-- Q12. Attendance summary per course (count of each status)
SELECT c.code, c.title,
       SUM(a.status = 'Present') AS present,
       SUM(a.status = 'Late')    AS late,
       SUM(a.status = 'Absent')  AS absent,
       SUM(a.status = 'Leave')   AS on_leave
FROM courses c
JOIN enrollments e ON e.course_id = c.id
JOIN attendance a  ON a.enrollment_id = e.id
GROUP BY c.id, c.code, c.title
ORDER BY c.code;

-- Q13. Class-by-class attendance for one date
SELECT a.status, COUNT(*) AS students
FROM attendance a
WHERE a.class_date = '2026-09-14'
GROUP BY a.status;

-- ---------- D. LEFT JOIN / IS NULL, marks, subqueries ----------

-- Q14. Students with no enrollments (LEFT JOIN ... IS NULL)
SELECT s.roll_no, s.name
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.id
WHERE e.id IS NULL;

-- Q15. Average marks per course (NULL marks are ignored by AVG)
SELECT c.code, c.title, COUNT(e.marks) AS graded, ROUND(AVG(e.marks), 2) AS avg_marks
FROM courses c
JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.code, c.title
HAVING graded > 0
ORDER BY avg_marks DESC;

-- Q16. Top 3 students by average marks
SELECT s.name, ROUND(AVG(e.marks), 2) AS avg_marks
FROM students s
JOIN enrollments e ON e.student_id = s.id
WHERE e.marks IS NOT NULL
GROUP BY s.id, s.name
ORDER BY avg_marks DESC
LIMIT 3;

-- Q17. Teacher workload: courses taught and students taught
SELECT t.name AS teacher,
       COUNT(DISTINCT c.id) AS courses,
       COUNT(e.id)          AS student_enrollments
FROM teachers t
LEFT JOIN courses c     ON c.teacher_id = t.id
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY t.id, t.name
ORDER BY student_enrollments DESC;

-- Q18. Department summary using subqueries
SELECT d.name AS department,
       (SELECT COUNT(*) FROM students s WHERE s.department_id = d.id) AS students,
       (SELECT COUNT(*) FROM teachers t WHERE t.department_id = d.id) AS teachers,
       (SELECT COUNT(*) FROM courses  c WHERE c.department_id = d.id) AS courses
FROM departments d
ORDER BY d.name;

-- ---------- E. CRUD statements (run inside a transaction, then undone) ----------

START TRANSACTION;
INSERT INTO students (department_id, name, email, roll_no, semester)
VALUES (4, 'Test Student', 'test.student@student.usindh.edu.pk', '2k24-CS-99', 1);          -- Create
SELECT id, name, roll_no FROM students WHERE roll_no = '2k24-CS-99';                          -- Read
UPDATE students SET semester = 2 WHERE roll_no = '2k24-CS-99';                                -- Update
DELETE FROM students WHERE roll_no = '2k24-CS-99';                                            -- Delete
ROLLBACK;   -- leaves the seed data unchanged
