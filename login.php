<?php

session_start();

require_once 'smarty/libs/Smarty.class.php';
require_once 'vendor/autoload.php';

$smarty = new Smarty();


$servername = "w014060b.kasserver.com";
$username   = "d03d2f58";
$password   = "P1r2i3n4z5";
$dbname     = "d03d2f58";

$conn       = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);

$username = $_POST['username'];
$password = $_POST['password'];

$select = $conn->prepare("SELECT username, password FROM accounts WHERE username = '$username' and password = '$password'");
$select->execute();
$account = $select->fetch(PDO::FETCH_ASSOC);


if ($username == $account['username'] and $password == $account['password']) {

    echo json_encode("success");
} else {
    echo json_encode("error");
}
