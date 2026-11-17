<?php
// Generated from database/queries.sql. Read-only report definitions (allow-list by id).
return [
  1 => [
    'group' => 'Basic SELECT and JOIN',
    'title' => 'Students with their department names (INNER JOIN)',
    'basic' => true,
    'sql'   => <<<'SQL'
SELECT s.id, s.roll_no, s.name, d.name AS department, s.semester
FROM students s
INNER JOIN departments d ON d.id = s.department_id
ORDER BY d.name, s.name;
SQL
  ],
  2 => [
    'group' => 'Basic SELECT and JOIN',
    'title' => 'Teachers with their departments',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT t.name AS teacher, t.designation, d.name AS department
FROM teachers t
JOIN departments d ON d.id = t.department_id
ORDER BY d.name, t.name;
SQL
  ],
  3 => [
    'group' => 'Basic SELECT and JOIN',
    'title' => 'Courses with department and teacher (LEFT JOIN keeps courses with no teacher)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT c.code, c.title, c.credit_hours, d.name AS department, t.name AS teacher
FROM courses c
JOIN departments d  ON d.id = c.department_id
LEFT JOIN teachers t ON t.id = c.teacher_id
ORDER BY c.code;
SQL
  ],
  4 => [
    'group' => 'Basic SELECT and JOIN',
    'title' => 'Which student is enrolled in which course (3-table JOIN)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.roll_no, s.name AS student, c.code, c.title, e.enrolled_on
FROM enrollments e
JOIN students s ON s.id = e.student_id
JOIN courses  c ON c.id = e.course_id
ORDER BY s.roll_no, c.code;
SQL
  ],
  5 => [
    'group' => 'GROUP BY and aggregates',
    'title' => 'Enrollment count per course (LEFT JOIN so empty courses show 0)',
    'basic' => true,
    'sql'   => <<<'SQL'
SELECT c.code, c.title, COUNT(e.id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.code, c.title
ORDER BY enrolled_students DESC, c.code;
SQL
  ],
  6 => [
    'group' => 'GROUP BY and aggregates',
    'title' => 'Number of students per department',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT d.name AS department, COUNT(s.id) AS total_students
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.id, d.name
ORDER BY total_students DESC;
SQL
  ],
  7 => [
    'group' => 'GROUP BY and aggregates',
    'title' => 'Students taking 3 or more courses (HAVING filters groups)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.name, COUNT(e.id) AS courses_taken
FROM students s
JOIN enrollments e ON e.student_id = s.id
GROUP BY s.id, s.name
HAVING COUNT(e.id) >= 3
ORDER BY courses_taken DESC, s.name;
SQL
  ],
  8 => [
    'group' => 'GROUP BY and aggregates',
    'title' => 'Total credit hours per student',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.name, SUM(c.credit_hours) AS total_credit_hours
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN courses c     ON c.id = e.course_id
GROUP BY s.id, s.name
ORDER BY total_credit_hours DESC;
SQL
  ],
  9 => [
    'group' => 'Attendance reports',
    'title' => 'Overall attendance percentage by student',
    'basic' => true,
    'sql'   => <<<'SQL'
SELECT s.roll_no, s.name,
       COUNT(a.id) AS classes_held,
       SUM(a.status IN ('Present','Late')) AS attended,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN attendance a  ON a.enrollment_id = e.id
GROUP BY s.id, s.roll_no, s.name
ORDER BY attendance_percent DESC;
SQL
  ],
  10 => [
    'group' => 'Attendance reports',
    'title' => 'Attendance percentage per student per course',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.name AS student, c.code AS course,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM attendance a
JOIN enrollments e ON e.id = a.enrollment_id
JOIN students s    ON s.id = e.student_id
JOIN courses c     ON c.id = e.course_id
GROUP BY s.id, s.name, c.id, c.code
ORDER BY s.name, c.code;
SQL
  ],
  11 => [
    'group' => 'Attendance reports',
    'title' => 'Students below 75% attendance (shortage list)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.roll_no, s.name,
       ROUND(100 * SUM(a.status IN ('Present','Late')) / COUNT(a.id), 2) AS attendance_percent
FROM students s
JOIN enrollments e ON e.student_id = s.id
JOIN attendance a  ON a.enrollment_id = e.id
GROUP BY s.id, s.roll_no, s.name
HAVING attendance_percent < 75
ORDER BY attendance_percent;
SQL
  ],
  12 => [
    'group' => 'Attendance reports',
    'title' => 'Attendance summary per course (count of each status)',
    'basic' => false,
    'sql'   => <<<'SQL'
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
SQL
  ],
  13 => [
    'group' => 'Attendance reports',
    'title' => 'Class-by-class attendance for one date',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT a.status, COUNT(*) AS students
FROM attendance a
WHERE a.class_date = '2026-09-14'
GROUP BY a.status;
SQL
  ],
  14 => [
    'group' => 'LEFT JOIN / IS NULL, marks, subqueries',
    'title' => 'Students with no enrollments (LEFT JOIN ... IS NULL)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.roll_no, s.name
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.id
WHERE e.id IS NULL;
SQL
  ],
  15 => [
    'group' => 'LEFT JOIN / IS NULL, marks, subqueries',
    'title' => 'Average marks per course (NULL marks are ignored by AVG)',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT c.code, c.title, COUNT(e.marks) AS graded, ROUND(AVG(e.marks), 2) AS avg_marks
FROM courses c
JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.code, c.title
HAVING graded > 0
ORDER BY avg_marks DESC;
SQL
  ],
  16 => [
    'group' => 'LEFT JOIN / IS NULL, marks, subqueries',
    'title' => 'Top 3 students by average marks',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT s.name, ROUND(AVG(e.marks), 2) AS avg_marks
FROM students s
JOIN enrollments e ON e.student_id = s.id
WHERE e.marks IS NOT NULL
GROUP BY s.id, s.name
ORDER BY avg_marks DESC
LIMIT 3;
SQL
  ],
  17 => [
    'group' => 'LEFT JOIN / IS NULL, marks, subqueries',
    'title' => 'Teacher workload: courses taught and students taught',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT t.name AS teacher,
       COUNT(DISTINCT c.id) AS courses,
       COUNT(e.id)          AS student_enrollments
FROM teachers t
LEFT JOIN courses c     ON c.teacher_id = t.id
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY t.id, t.name
ORDER BY student_enrollments DESC;
SQL
  ],
  18 => [
    'group' => 'LEFT JOIN / IS NULL, marks, subqueries',
    'title' => 'Department summary using subqueries',
    'basic' => false,
    'sql'   => <<<'SQL'
SELECT d.name AS department,
       (SELECT COUNT(*) FROM students s WHERE s.department_id = d.id) AS students,
       (SELECT COUNT(*) FROM teachers t WHERE t.department_id = d.id) AS teachers,
       (SELECT COUNT(*) FROM courses  c WHERE c.department_id = d.id) AS courses
FROM departments d
ORDER BY d.name;
SQL
  ],
];
