<?php
function timeConversion($s) {
    $date = DateTime::createFromFormat('h:i:sA', $s);
    echo $date->format('H:i:s') . "\n";
}

$s = "07:05:45PM";
timeConversion($s);

?>
