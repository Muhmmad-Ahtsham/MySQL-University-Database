<?php
require __DIR__ . '/../includes/functions.php';

// Only ids that exist in the allow-list can run: no user-supplied SQL is ever executed
$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$all = reports();
if (!$id || !isset($all[$id])) {
    http_response_code(404);
    $id = null;
}

$pageTitle = $id ? "Q$id " . $all[$id]['title'] : 'Report not found';
require __DIR__ . '/../includes/header.php';

if (!$id): ?>
  <div class="alert error">Report not found. <a href="index.php">Back to all reports</a></div>
<?php else:
    $report = $all[$id];
    $start = microtime(true);
    $rows = db()->query($report['sql'])->fetchAll();
    $ms = round((microtime(true) - $start) * 1000, 1);
?>
<div class="title-row">
  <h1>Q<?= $id ?>. <?= e($report['title']) ?></h1>
  <div>
    <?php if (isset($all[$id - 1])): ?><a class="btn" href="view.php?id=<?= $id - 1 ?>">&larr; Prev</a><?php endif; ?>
    <a class="btn" href="index.php">All reports</a>
    <?php if (isset($all[$id + 1])): ?><a class="btn" href="view.php?id=<?= $id + 1 ?>">Next &rarr;</a><?php endif; ?>
  </div>
</div>
<p class="muted"><?= e($report['group']) ?></p>

<section class="panel">
  <h2>SQL query</h2>
  <pre class="sql"><?= e($report['sql']) ?></pre>
</section>

<section class="panel">
  <h2>Result <small class="muted">&mdash; <?= count($rows) ?> row(s) in <?= $ms ?> ms</small></h2>
  <?php render_table($rows, $report['title']); ?>
</section>
<?php endif;
require __DIR__ . '/../includes/footer.php'; ?>
