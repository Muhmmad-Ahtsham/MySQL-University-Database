# University Portal - Lab 10: MySQL + SQL

University relational database (`university_portal`) with a PHP website to browse it.
Tables: **departments, teachers, students, courses, enrollments, attendance**.

## Run it (3 steps)
1. Extract this zip into **`C:\xampp\htdocs\`** so you get `C:\xampp\htdocs\university-portal\`.
2. Open the **XAMPP Control Panel** and start **Apache** and **MySQL**.
3. Open **http://localhost/university-portal/**

The database, tables and seed data are created **automatically** on the first visit.
Nothing needs to be imported or created by hand.

Optional: **Setup** page resets the database to the original seed data.
If MySQL has a root password, set it in `config/database.php`.

## Folder structure (matches the lab manual)
```
university-portal/
├── config/database.php        database settings
├── database/
│   ├── schema.sql             schema + seed data  (SUBMIT THIS)
│   ├── queries.sql            18 SQL queries + CRUD examples
│   └── university_portal_export.sql   full export (structure + data)
├── reports/                   the 18 queries as web pages
│   ├── index.php  view.php  queries.php
├── includes/                  shared header, footer, functions
├── assets/style.css
├── docs/Lab_Report.md         lab report to complete and submit
├── screenshots/               put your screenshots here
├── index.php  tables.php  schema.php  export.php  setup.php
```

## Using phpMyAdmin (for screenshots)
Open http://localhost/phpmyadmin -> select **university_portal**.
- **Table list**: the *Structure* tab shows all six tables.
- **Relations view**: *More -> Designer* shows the foreign-key links.
- **Run queries**: *SQL* tab -> paste any query from `database/queries.sql`.
- **Export**: *Export* tab -> Quick -> SQL -> Export.
To import manually instead: *Import* tab -> choose `database/schema.sql`.

## Required screenshots (see screenshots/README.txt)
Table list, relations view, a JOIN result, enrollment counts, attendance percentage, export.

## Pages
| URL | What it shows |
|---|---|
| `/university-portal/` | Dashboard with row counts and key reports |
| `tables.php` | Browse all six tables |
| `schema.php` | ER-style schema and foreign keys |
| `reports/` | All 18 SQL queries with results |
| `export.php` | Download the SQL export |
| `setup.php` | Reset the database |
