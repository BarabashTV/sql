
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS teachers CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS registrations CASCADE;
DROP TABLE IF EXISTS grades CASCADE;

CREATE TABLE "courses"(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY,
    "course_name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "teacher_id" INTEGER NULL
);
ALTER TABLE
    "courses" ADD PRIMARY KEY("id");
CREATE TABLE "teachers"(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "teachers" ADD PRIMARY KEY("id");
CREATE TABLE "grades"(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY,
    "registration_id" INTEGER NOT NULL,
    "grade" VARCHAR(255) NOT NULL,
    "date" DATE NOT NULL,
    "teacher_id" INTEGER NOT NULL
);
ALTER TABLE
    "grades" ADD PRIMARY KEY("id");
CREATE TABLE "students"(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "birth_date" DATE NOT NULL
);
ALTER TABLE
    "students" ADD PRIMARY KEY("id");
CREATE TABLE "registrations"(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY,
    "student_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL
);
ALTER TABLE
    "registrations" ADD PRIMARY KEY("id");
ALTER TABLE
    "grades" ADD CONSTRAINT "grades_teacher_id_foreign" FOREIGN KEY("teacher_id") REFERENCES "teachers"("id");
ALTER TABLE
    "courses" ADD CONSTRAINT "courses_teacher_id_foreign" FOREIGN KEY("teacher_id") REFERENCES "teachers"("id");
ALTER TABLE
    "registrations" ADD CONSTRAINT "registrations_student_id_foreign" FOREIGN KEY("student_id") REFERENCES "students"("id");
ALTER TABLE
    "grades" ADD CONSTRAINT "grades_registration_id_foreign" FOREIGN KEY("registration_id") REFERENCES "registrations"("id");
ALTER TABLE
    "registrations" ADD CONSTRAINT "registrations_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");

INSERT INTO teachers (first_name, last_name, email, phone)
VALUES ('Juha', 'Konttinen', 'juha.konttinen@bc.com', '040-111-11-11');
INSERT INTO teachers (first_name, last_name, email, phone)
VALUES ('Paavo', 'Penttila', 'paavo.penttila@bc.com', '040-222-22-22');
INSERT INTO teachers (first_name, last_name, email, phone)
VALUES ('Mikko', 'Forsström', 'mikko.forsström@bc.com', '040-333-33-33');

INSERT INTO students (first_name, last_name, email, phone, birth_date)
VALUES ('Ella', 'Smith', 'ella.smith@bc.com', '040-444-44-44', '1999-05-05');
INSERT INTO students (first_name, last_name, email, phone, birth_date)
VALUES ('John', 'Johnson', 'john.johnson@bc.com', '040-555-55-55', '1994-01-01');
INSERT INTO students (first_name, last_name, email, phone, birth_date)
VALUES ('David', 'Davidson', 'david.davidson@bc.com', '040-666-66-66', '2000-02-02');

INSERT INTO courses (course_name, description, teacher_id)
VALUES ('SQL', 'SQL ja relaatiotietokannat', 3);
INSERT INTO courses (course_name, description, teacher_id)
VALUES ('React', 'Nykyaikaisten verkkosovellusten kehittäminen', 1);
INSERT INTO courses (course_name, description, teacher_id)
VALUES ('Wordpress', 'Oman WordPress-teeman kehittäminen ja toteutus', 2);

INSERT INTO registrations (student_id, course_id)
VALUES (1, 2);
INSERT INTO registrations (student_id, course_id)
VALUES (1, 3);
INSERT INTO registrations (student_id, course_id)
VALUES (2, 1);
INSERT INTO registrations (student_id, course_id)
VALUES (2, 2);
INSERT INTO registrations (student_id, course_id)
VALUES (2, 3);
INSERT INTO registrations (student_id, course_id)
VALUES (3, 2);
INSERT INTO registrations (student_id, course_id)
VALUES (3, 3);

INSERT INTO grades (registration_id, grade, date, teacher_id)
VALUES (1, 'S', '2024-10-07', 3);
INSERT INTO grades (registration_id, grade, date, teacher_id)
VALUES (2, 'S+', '2024-10-14', 1);
INSERT INTO grades (registration_id, grade, date, teacher_id)
VALUES (3, 'S', '2024-10-20', 2); 


SELECT students.first_name, students.last_name, students.email
FROM students
JOIN registrations ON students.id = registrations.student_id
JOIN courses ON registrations.course_id = courses.id
WHERE courses.course_name = 'SQL';

SELECT students.first_name, students.last_name, students.email, courses.course_name
FROM students
JOIN registrations ON students.id = registrations.student_id
JOIN courses ON registrations.course_id = courses.id;

