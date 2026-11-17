<?php
require __DIR__ . '/includes/functions.php';
$pdo = db();

// Allow-list: table names cannot be bound as parameters, so validate against known names
$table = $_GET['table'] ?? DB_TABLES[0];
if (!in_array($table, DB_TABLES, true)) {
    $table = DB_TABLES[0];
}
$perPage = 25;
$total = table_count($table);
$pages = max(1, (int) ceil($total / $perPage));
$page = min(max(1, (int) filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT)), $pages);
$offset = ($page - 1) * $perPage;

$rows = $pdo->query("SELECT * FROM `$table` ORDER BY id LIMIT $perPage OFFSET $offset")->fetchAll();

$pageTitle = ucfirst($table) . ' table';
require __DIR__ . '/includes/header.php';
?>
<h1>Browse Tables</h1>
<div class="tabs" role="tablist">
  <?php foreach (DB_TABLES as $t): ?>
    <a href="tables.php?table=<?= e($t) ?>" class="<?= $t === $table ? 'active' : '' ?>"><?= e($t) ?> <small><?= table_count($t) ?></small></a>
  <?php endforeach; ?>
</div>
<section class="panel">
  <h2><?= e($table) ?> <small class="muted">&mdash; showing <?= $total ? $offset + 1 : 0 ?>-<?= min($offset + $perPage, $total) ?> of <?= $total ?></small></h2>
  <?php render_table($rows, $table); ?>
  <?php if ($pages > 1): ?>
    <nav class="pagination" aria-label="Pagination">
      <?php for ($p = 1; $p <= $pages; $p++): ?>
        <a class="<?= $p === $page ? 'active' : '' ?>" href="tables.php?table=<?= e($table) ?>&amp;page=<?= $p ?>"><?= $p ?></a>
      <?php endfor; ?>
    </nav>
  <?php endif; ?>
</section>
<?php require __DIR__ . '/includes/footer.php'; ?>
