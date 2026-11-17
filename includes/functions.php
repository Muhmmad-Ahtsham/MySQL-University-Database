<?php
declare(strict_types=1);

// Tables in dependency order (parents first)
const DB_TABLES = ['departments', 'teachers', 'students', 'courses', 'enrollments', 'attendance'];

// Pages inside /reports need "../" in front of links
define('BASE', basename(dirname($_SERVER['SCRIPT_FILENAME'])) === 'reports' ? '../' : '');

function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

function db_config(): array
{
    return require __DIR__ . '/../config/database.php';
}

function pdo_options(): array
{
    return [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC];
}

/** Runs database/schema.sql: creates university_portal, all six tables and the seed data. */
function install_database(): void
{
    $c = db_config();
    $pdo = new PDO("mysql:host={$c['host']};charset=utf8mb4", $c['user'], $c['pass'], pdo_options());
    $pdo->exec((string) file_get_contents(__DIR__ . '/../database/schema.sql'));
}

function show_fatal(string $title, string $html): never
{
    $pageTitle = $title;
    require __DIR__ . '/header.php';
    echo '<div class="alert error"><strong>' . e($title) . '</strong><br>' . $html . '</div>';
    require __DIR__ . '/footer.php';
    exit;
}

/**
 * Returns the database connection. On first run it installs the database automatically
 * (unknown database, or a database with none of the six tables).
 */
function db(): PDO
{
    static $pdo = null;
    if ($pdo instanceof PDO) {
        return $pdo;
    }
    $c = db_config();
    $dsn = "mysql:host={$c['host']};dbname={$c['name']};charset=utf8mb4";

    try {
        try {
            $pdo = new PDO($dsn, $c['user'], $c['pass'], pdo_options());
        } catch (PDOException $ex) {
            if ((int) $ex->getCode() !== 1049 && !str_contains($ex->getMessage(), '[1049]')) {
                throw $ex;                                   // not "unknown database"
            }
            install_database();                              // first run: build everything
            $pdo = new PDO($dsn, $c['user'], $c['pass'], pdo_options());
        }

        $in = "'" . implode("','", DB_TABLES) . "'";
        $found = (int) $pdo->query("SELECT COUNT(*) FROM information_schema.TABLES
                                    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN ($in)")->fetchColumn();
        if ($found === 0) {
            install_database();                              // database exists but is empty
        } elseif ($found < count(DB_TABLES)) {
            show_fatal('Some tables are missing',
                'Only ' . $found . ' of ' . count(DB_TABLES) . ' tables exist. Open the '
                . '<a href="' . BASE . 'setup.php">Setup page</a> to rebuild the database.');
        }
    } catch (PDOException $ex) {
        show_fatal('Cannot connect to MySQL',
            'Start <strong>MySQL</strong> in the XAMPP Control Panel, then refresh this page.<br>'
            . 'If your MySQL user has a password, set it in <code>config/database.php</code>.<br>'
            . '<small>' . e($ex->getMessage()) . '</small>');
    }
    return $pdo;
}

function table_count(string $table): int
{
    if (!in_array($table, DB_TABLES, true)) {
        return 0;
    }
    return (int) db()->query("SELECT COUNT(*) FROM `$table`")->fetchColumn();
}

function reports(): array
{
    static $list = null;
    return $list ??= require __DIR__ . '/../reports/queries.php';
}

/** Prints an array of associative rows as an HTML table. */
function render_table(array $rows, string $caption = ''): void
{
    if (!$rows) {
        echo '<p class="empty">No rows returned.</p>';
        return;
    }
    echo '<div class="table-wrap"><table>';
    if ($caption !== '') {
        echo '<caption class="sr-only">' . e($caption) . '</caption>';
    }
    echo '<thead><tr>';
    foreach (array_keys($rows[0]) as $col) {
        echo '<th>' . e($col) . '</th>';
    }
    echo '</tr></thead><tbody>';
    foreach ($rows as $row) {
        echo '<tr>';
        foreach ($row as $value) {
            echo '<td>' . ($value === null ? '<span class="null">NULL</span>' : e($value)) . '</td>';
        }
        echo '</tr>';
    }
    echo '</tbody></table></div>';
}
