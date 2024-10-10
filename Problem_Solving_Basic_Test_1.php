<?php
function miniMaxSum($arr) {
    sort($arr);

    $minSum = array_sum(array_slice($arr, 0, 4));

    $maxSum = array_sum(array_slice($arr, 1, 4));

    echo $minSum . ' ' . $maxSum . "\n";
}

$arr = [1, 2, 3, 4, 5];

miniMaxSum($arr);
?>
