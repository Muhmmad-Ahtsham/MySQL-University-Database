-- ============================================================
-- Lab 10: University Relational Database  (university_portal)
-- Tables: departments, teachers, students, courses,
--         enrollments, attendance
-- Run in phpMyAdmin (Import tab or SQL tab) or:
--   mysql -u root < schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS university_portal
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE university_portal;

-- Drop in reverse dependency order so the script can be re-run safely
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS departments;

-- ------------------------------------------------------------
-- 1. Tables (created in dependency order: parents first)
-- ------------------------------------------------------------

CREATE TABLE departments (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE,
  code  VARCHAR(10)  NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE teachers (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  department_id INT NOT NULL,
  name          VARCHAR(120) NOT NULL,
  email         VARCHAR(150) NOT NULL UNIQUE,
  designation   VARCHAR(60)  NOT NULL,
  FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

-- Same core columns as the Lab 11 reference (department_id, name, email);
-- roll_no and semester are extra columns with safe defaults.
CREATE TABLE students (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  department_id INT NOT NULL,
  name          VARCHAR(120) NOT NULL,
  email         VARCHAR(150) NOT NULL UNIQUE,
  roll_no       VARCHAR(30)  NULL UNIQUE,
  semester      TINYINT NOT NULL DEFAULT 1,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_student_semester CHECK (semester BETWEEN 1 AND 8),
  FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

CREATE TABLE courses (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  department_id INT NOT NULL,
  teacher_id    INT NULL,
  code          VARCHAR(10)  NOT NULL UNIQUE,
  title         VARCHAR(120) NOT NULL,
  credit_hours  TINYINT NOT NULL DEFAULT 3,
  CONSTRAINT chk_course_credits CHECK (credit_hours BETWEEN 1 AND 6),
  FOREIGN KEY (department_id) REFERENCES departments(id),
  FOREIGN KEY (teacher_id)    REFERENCES teachers(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Many-to-many link: a student takes many courses, a course has many students
CREATE TABLE enrollments (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  student_id  INT NOT NULL,
  course_id   INT NOT NULL,
  enrolled_on DATE NOT NULL,
  marks       DECIMAL(5,2) NULL,                 -- NULL = course still in progress
  CONSTRAINT chk_marks CHECK (marks IS NULL OR marks BETWEEN 0 AND 100),
  CONSTRAINT uq_student_course UNIQUE (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  FOREIGN KEY (course_id)  REFERENCES courses(id)  ON DELETE CASCADE
) ENGINE=InnoDB;

-- One row per enrollment per class date
CREATE TABLE attendance (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  enrollment_id INT NOT NULL,
  class_date    DATE NOT NULL,
  status        ENUM('Present','Absent','Late','Leave') NOT NULL DEFAULT 'Present',
  CONSTRAINT uq_enrollment_date UNIQUE (enrollment_id, class_date),
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 2. Seed data (parents first, then children)
-- ------------------------------------------------------------

INSERT INTO departments (name, code) VALUES
  ('Software Engineering',   'SE'),
  ('Information Technology', 'IT'),
  ('Data Science',           'DS'),
  ('Computer Science',       'CS');

INSERT INTO teachers (department_id, name, email, designation) VALUES
  (1, 'Dr. Sara Khan',      'sara.khan@usindh.edu.pk',      'Associate Professor'),
  (1, 'Mr. Rafique Bhutto', 'rafique.bhutto@usindh.edu.pk', 'Lecturer'),
  (2, 'Ms. Farah Soomro',   'farah.soomro@usindh.edu.pk',   'Assistant Professor'),
  (2, 'Dr. Zahid Jatoi',    'zahid.jatoi@usindh.edu.pk',    'Professor'),
  (3, 'Dr. Nida Qureshi',   'nida.qureshi@usindh.edu.pk',   'Associate Professor'),
  (4, 'Mr. Kamran Rind',    'kamran.rind@usindh.edu.pk',    'Lecturer');

INSERT INTO students (department_id, name, email, roll_no, semester) VALUES
  (1, 'Ali Ahmed',      'ali.ahmed@student.usindh.edu.pk',      '2k24-SE-01', 3),
  (1, 'Hina Memon',     'hina.memon@student.usindh.edu.pk',     '2k24-SE-02', 3),
  (1, 'Usman Chandio',  'usman.chandio@student.usindh.edu.pk',  '2k24-SE-03', 3),
  (1, 'Maria Shaikh',   'maria.shaikh@student.usindh.edu.pk',   '2k24-SE-04', 5),
  (2, 'Sana Lashari',   'sana.lashari@student.usindh.edu.pk',   '2k24-IT-01', 3),
  (2, 'Bilal Mirani',   'bilal.mirani@student.usindh.edu.pk',   '2k24-IT-02', 5),
  (2, 'Zoya Khan',      'zoya.khan@student.usindh.edu.pk',      '2k24-IT-03', 3),
  (2, 'Danish Rajput',  'danish.rajput@student.usindh.edu.pk',  '2k24-IT-04', 5),
  (3, 'Areeba Siddiqui','areeba.siddiqui@student.usindh.edu.pk','2k24-DS-01', 3),
  (3, 'Faisal Abbasi',  'faisal.abbasi@student.usindh.edu.pk',  '2k24-DS-02', 5),
  (3, 'Noor Fatima',    'noor.fatima@student.usindh.edu.pk',    '2k24-DS-03', 3),
  (4, 'Imran Panhwar',  'imran.panhwar@student.usindh.edu.pk',  '2k24-CS-01', 1);   -- no enrollments yet

INSERT INTO courses (department_id, teacher_id, code, title, credit_hours) VALUES
  (1, 1, 'SE-101', 'Programming Fundamentals', 4),
  (1, 2, 'SE-310', 'Web Technologies',         4),
  (2, 3, 'IT-205', 'Database Systems',         4),
  (2, 4, 'IT-220', 'Computer Networks',        3),
  (3, 5, 'DS-201', 'Statistics for Data Science', 3),
  (3, 5, 'DS-310', 'Machine Learning',         3),
  (4, 6, 'CS-101', 'Introduction to Computing', 3),
  (4, 6, 'CS-230', 'Data Structures',          4);                                 -- no enrollments yet

-- (student_id, course_id) pairs: 33 enrollments
INSERT INTO enrollments (student_id, course_id, enrolled_on) VALUES
  (1,1,'2026-09-01'),(1,2,'2026-09-01'),(1,3,'2026-09-01'),
  (2,1,'2026-09-01'),(2,2,'2026-09-01'),(2,3,'2026-09-02'),
  (3,1,'2026-09-02'),(3,2,'2026-09-02'),(3,7,'2026-09-02'),
  (4,1,'2026-09-02'),(4,3,'2026-09-02'),(4,4,'2026-09-03'),
  (5,3,'2026-09-03'),(5,4,'2026-09-03'),(5,2,'2026-09-03'),
  (6,3,'2026-09-03'),(6,4,'2026-09-03'),(6,7,'2026-09-04'),
  (7,4,'2026-09-04'),(7,3,'2026-09-04'),(7,5,'2026-09-04'),
  (8,4,'2026-09-04'),(8,3,'2026-09-04'),(8,1,'2026-09-05'),
  (9,5,'2026-09-05'),(9,6,'2026-09-05'),(9,7,'2026-09-05'),
  (10,5,'2026-09-05'),(10,6,'2026-09-06'),(10,2,'2026-09-06'),
  (11,5,'2026-09-06'),(11,6,'2026-09-06'),(11,3,'2026-09-06');

-- Marks for the first 27 enrollments; the rest stay NULL (in progress)
UPDATE enrollments SET marks = 55 + MOD(id * 13, 40) WHERE id <= 27;

-- Attendance: six Monday classes per enrollment (198 rows), generated with a
-- repeatable pattern so every student gets a realistic mix of statuses
INSERT INTO attendance (enrollment_id, class_date, status)
SELECT e.id, d.class_date,
       CASE MOD(e.id * e.id + (DATEDIFF(d.class_date, '2026-09-07') DIV 7) * e.student_id * 3 + e.id, 14)
            WHEN 0 THEN 'Absent'
            WHEN 1 THEN 'Absent'
            WHEN 2 THEN 'Late'
            WHEN 3 THEN 'Leave'
            ELSE 'Present' END
FROM enrollments e
CROSS JOIN (
  SELECT '2026-09-07' AS class_date UNION ALL SELECT '2026-09-14'
  UNION ALL SELECT '2026-09-21' UNION ALL SELECT '2026-09-28'
  UNION ALL SELECT '2026-10-05' UNION ALL SELECT '2026-10-12'
) AS d;
