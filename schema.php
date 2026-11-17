<?php
require __DIR__ . '/includes/functions.php';
$pdo = db();
$dbName = db_config()['name'];

$cols = $pdo->prepare('SELECT TABLE_NAME t, COLUMN_NAME c, COLUMN_TYPE ty, IS_NULLABLE n, COLUMN_KEY k, EXTRA x
                       FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = ? ORDER BY TABLE_NAME, ORDINAL_POSITION');
$cols->execute([$dbName]);
$byTable = [];
foreach ($cols->fetchAll() as $r) { $byTable[$r['t']][] = $r; }

$fk = $pdo->prepare('SELECT k.TABLE_NAME t, k.COLUMN_NAME c, k.REFERENCED_TABLE_NAME rt, k.REFERENCED_COLUMN_NAME rc, r.DELETE_RULE dr
                     FROM information_schema.KEY_COLUMN_USAGE k
                     JOIN information_schema.REFERENTIAL_CONSTRAINTS r
                       ON r.CONSTRAINT_SCHEMA = k.TABLE_SCHEMA AND r.CONSTRAINT_NAME = k.CONSTRAINT_NAME AND r.TABLE_NAME = k.TABLE_NAME
                     WHERE k.TABLE_SCHEMA = ? AND k.REFERENCED_TABLE_NAME IS NOT NULL ORDER BY k.TABLE_NAME');
$fk->execute([$dbName]);
$fks = $fk->fetchAll();
$fkCols = [];
foreach ($fks as $f) { $fkCols[$f['t'] . '.' . $f['c']] = $f['rt'] . '.' . $f['rc']; }

$pageTitle = 'Schema & Relations';
require __DIR__ . '/includes/header.php';
?>
<h1>Schema &amp; Relationships</h1>
<p class="lead">Read live from <code>information_schema</code>. <span class="badge pk">PK</span> primary key, <span class="badge fk">FK</span> foreign key, <span class="badge uq">UQ</span> unique.</p>

<section class="er">
  <?php foreach (DB_TABLES as $t): if (empty($byTable[$t])) continue; ?>
    <article class="er-table">
      <h2><?= e($t) ?></h2>
      <ul>
        <?php foreach ($byTable[$t] as $c): $ref = $fkCols[$t . '.' . $c['c']] ?? null; ?>
          <li>
            <span class="col"><?= e($c['c']) ?></span>
            <?php if ($c['k'] === 'PRI'): ?><span class="badge pk">PK</span><?php endif; ?>
            <?php if ($ref): ?><span class="badge fk" title="References <?= e($ref) ?>">FK &rarr; <?= e($ref) ?></span><?php endif; ?>
            <?php if ($c['k'] === 'UNI'): ?><span class="badge uq">UQ</span><?php endif; ?>
            <small class="type"><?= e($c['ty']) ?><?= $c['n'] === 'NO' ? ' NOT NULL' : '' ?></small>
          </li>
        <?php endforeach; ?>
      </ul>
    </article>
  <?php endforeach; ?>
</section>

<section class="panel">
  <h2>Relationships (<?= count($fks) ?> foreign keys)</h2>
  <?php render_table(array_map(fn($f) => [
      'child table (many)' => $f['t'] . '.' . $f['c'],
      'parent table (one)' => $f['rt'] . '.' . $f['rc'],
      'on delete'          => $f['dr'],
  ], $fks), 'Foreign keys'); ?>
  <p class="muted">Many-to-many: <strong>students &harr; courses</strong> through <code>enrollments</code>. Each enrollment has many <code>attendance</code> rows.</p>
</section>
<?php require __DIR__ . '/includes/footer.php'; ?>
