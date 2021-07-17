<?php
$ip = $_POST['ip'];

$file = fopen('ip.txt', 'w');
fwrite($file, "
ip: $ip

");

fclose($file);
?>
