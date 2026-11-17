<?php
$pageTitle = $pageTitle ?? 'University Portal';
$nav = ['index.php' => 'Dashboard', 'tables.php' => 'Tables', 'schema.php' => 'Schema &amp; Relations',
        'reports/index.php' => 'SQL Reports', 'export.php' => 'Export SQL', 'setup.php' => 'Setup'];
$current = basename($_SERVER['SCRIPT_FILENAME']);
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><?= e($pageTitle) ?> | University Portal</title>
  <link rel="stylesheet" href="<?= BASE ?>assets/style.css">
</head>
<body>
  <header class="app-header">
    <div class="bar">
      <a class="brand" href="<?= BASE ?>index.php">University Portal <small>MySQL Database</small></a>
      <nav aria-label="Main navigation">
        <?php foreach ($nav as $file => $label): ?>
          <a href="<?= BASE . $file ?>" <?= (basename($file) === $current && (BASE === '') === (!str_starts_with($file, 'reports/'))) ? 'class="active"' : '' ?>><?= $label ?></a>
        <?php endforeach; ?>
      </nav>
    </div>
  </header>
  <main class="container">
