<?php
require __DIR__ . '/includes/functions.php';

/** Builds a full SQL dump: structure plus data for every table. */
function build_dump(PDO $pdo, string $dbName): string
{
    $out  = "-- University Portal export\n-- Generated: " . date('Y-m-d H:i:s') . "\n\n";
    $out .= "CREATE DATABASE IF NOT EXISTS `$dbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\nUSE `$dbName`;\n";
    $out .= "SET FOREIGN_KEY_CHECKS = 0;\n\n";
    foreach (DB_TABLES as $t) {
        $create = $pdo->query("SHOW CREATE TABLE `$t`")->fetch(PDO::FETCH_NUM)[1];
        $out .= "DROP TABLE IF EXISTS `$t`;\n$create;\n\n";
        $rows = $pdo->query("SELECT * FROM `$t` ORDER BY id")->fetchAll();
        if ($rows) {
            $cols = '`' . implode('`, `', array_keys($rows[0])) . '`';
            $out .= "INSERT INTO `$t` ($cols) VALUES\n";
            $vals = [];
            foreach ($rows as $row) {
                $vals[] = '(' . implode(', ', array_map(fn($v) => $v === null ? 'NULL' : $pdo->quote((string) $v), $row)) . ')';
            }
            $out .= implode(",\n", $vals) . ";\n\n";
        }
    }
    return $out . "SET FOREIGN_KEY_CHECKS = 1;\n";
}

$pdo = db();
if (isset($_GET['download'])) {
    $sql = build_dump($pdo, db_config()['name']);
    header('Content-Type: application/sql; charset=utf-8');
    header('Content-Disposition: attachment; filename="university_portal_export.sql"');
    header('Content-Length: ' . strlen($sql));
    echo $sql;
    exit;
}

$pageTitle = 'Export SQL';
require __DIR__ . '/includes/header.php';
?>
<h1>Export SQL</h1>
<section class="panel">
  <p>Download a complete backup of <code>university_portal</code> (all six tables with structure and data). You can import it into any MySQL server with phpMyAdmin.</p>
  <p>
    <a class="btn primary" href="export.php?download=1">&#11015; Download university_portal_export.sql</a>
    <a class="btn" href="database/schema.sql" download>Download schema.sql</a>
    <a class="btn" href="database/queries.sql" download>Download queries.sql</a>
  </p>
  <h2>Table summary</h2>
  <?php render_table(array_map(fn($t) => ['table' => $t, 'rows' => table_count($t)], DB_TABLES), 'Row counts'); ?>
  <p class="muted">phpMyAdmin alternative: select the database &rarr; <strong>Export</strong> tab &rarr; Quick &rarr; SQL &rarr; Export.</p>
</section>
<?php require __DIR__ . '/includes/footer.php'; ?>
