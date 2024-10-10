<?php
function plusMinus($arr) {
    $count = count($arr);
    $positiveCount = 0;
    $negativeCount = 0;
    $zeroCount = 0;

    foreach ($arr as $value) {
        if ($value > 0) {
            $positiveCount++;
        } elseif ($value < 0) {
            $negativeCount++;
        } else {
            $zeroCount++;
        }
    }

    printf("%.6f\n", $positiveCount / $count);
    printf("%.6f\n", $negativeCount / $count);
    printf("%.6f\n", $zeroCount / $count);
}

$arr = [-4, 3, -9, 0, 4, 1];
plusMinus($arr);

?>
