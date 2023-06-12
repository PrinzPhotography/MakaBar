<?php
require_once 'vendor/autoload.php';

use classes\Account;

//require_once ('classes/Account.php');

$servername = "w014060b.kasserver.com";
$username   = "d03d2f58";
$password   = "P1r2i3n4z5";
$dbname     = "d03d2f58";

$conn       = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);

$name = $_POST["name"];
$cocktail = $_POST["cocktail"];

$account = new Account($name);

$insert = $conn->prepare("INSERT INTO bestellungen (name, cocktail, preis) VALUES('$name', '$cocktail', 2)");
$insert->execute();

echo json_encode("ok");
