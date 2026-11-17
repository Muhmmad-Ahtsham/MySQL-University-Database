<?php
require __DIR__ . '/../includes/functions.php';
$pageTitle = 'SQL Reports';
require __DIR__ . '/../includes/header.php';

$groups = [];
foreach (reports() as $id => $r) { $groups[$r['group']][$id] = $r; }
?>
<h1>SQL Reports <small class="muted">(<?= count(reports()) ?> queries)</small></h1>
<p class="lead">Each report shows the SQL and runs it on your database. Reports marked <span class="badge pk">Lab task</span> are the Basic-task queries from the manual.</p>

<?php foreach ($groups as $group => $items): ?>
  <section class="panel">
    <h2><?= e($group) ?></h2>
    <ul class="report-list">
      <?php foreach ($items as $id => $r): ?>
        <li>
          <a href="view.php?id=<?= $id ?>"><strong>Q<?= $id ?></strong> <?= e($r['title']) ?></a>
          <?php if ($r['basic']): ?><span class="badge pk">Lab task</span><?php endif; ?>
        </li>
      <?php endforeach; ?>
    </ul>
  </section>
<?php endforeach; ?>
<?php require __DIR__ . '/../includes/footer.php'; ?>
