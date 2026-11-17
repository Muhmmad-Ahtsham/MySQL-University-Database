<?php
require __DIR__ . '/includes/functions.php';

$message = '';
$ok = false;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['confirm'] ?? '') === 'yes') {
    try {
        install_database();                    // runs database/schema.sql
        $ok = true;
        $message = 'Database created and seeded successfully.';
    } catch (Throwable $ex) {
        $message = 'Setup failed: ' . $ex->getMessage();
    }
}

$pageTitle = 'Setup';
require __DIR__ . '/includes/header.php';
?>
<h1>Database Setup</h1>
<?php if ($message): ?>
  <div class="alert <?= $ok ? 'success' : 'error' ?>" role="status"><?= e($message) ?>
    <?php if ($ok): ?> <a href="index.php">Open the dashboard &rarr;</a><?php endif; ?></div>
<?php endif; ?>
<section class="panel">
  <p>The site installs itself automatically on first visit. Use this page only to <strong>reset</strong> the database to its original seed data. It runs <code>database/schema.sql</code>, which creates <code>university_portal</code> with six tables and inserts the seed data.</p>
  <p class="warn"><strong>Warning:</strong> existing tables with these names are dropped and recreated, so any changes you made are lost.</p>
  <form method="post" action="setup.php">
    <input type="hidden" name="confirm" value="yes">
    <button type="submit" class="btn primary" onclick="return confirm('Drop and recreate all university_portal tables?');">Create / Reset Database</button>
  </form>
  <p class="muted">Connection: <code><?= e(db_config()['user']) ?>@<?= e(db_config()['host']) ?></code> &mdash; edit <code>config/database.php</code> if your credentials differ.</p>
</section>
<?php require __DIR__ . '/includes/footer.php'; ?>
