<?php
require __DIR__ . '/includes/functions.php';
$pdo = db();
$pageTitle = 'Dashboard';
require __DIR__ . '/includes/header.php';

$overall = $pdo->query("SELECT ROUND(100*SUM(status IN ('Present','Late'))/COUNT(*),1) FROM attendance")->fetchColumn();
?>
<h1>University Portal Dashboard</h1>
<p class="lead">Live view of the <code>university_portal</code> database: six related tables, seed data and SQL reports.</p>

<section class="cards" aria-label="Table row counts">
  <?php foreach (DB_TABLES as $t): ?>
    <a class="card" href="tables.php?table=<?= e($t) ?>">
      <span><?= table_count($t) ?></span><small><?= e(ucfirst($t)) ?></small>
    </a>
  <?php endforeach; ?>
</section>

<section class="cards two">
  <div class="card"><span><?= e($overall) ?>%</span><small>Overall attendance (Present + Late)</small></div>
  <div class="card"><span><?= count(reports()) ?></span><small>SQL reports available</small></div>
</section>

<div class="grid-2">
  <section class="panel">
    <h2>Enrollments per course <a class="sm" href="reports/view.php?id=5">Q5 &rarr;</a></h2>
    <?php render_table($pdo->query(reports()[5]['sql'])->fetchAll(), 'Enrollments per course'); ?>
  </section>
  <section class="panel">
    <h2>Attendance below 75% <a class="sm" href="reports/view.php?id=11">Q11 &rarr;</a></h2>
    <?php render_table($pdo->query(reports()[11]['sql'])->fetchAll(), 'Attendance shortage'); ?>
  </section>
</div>
<?php require __DIR__ . '/includes/footer.php'; ?>
