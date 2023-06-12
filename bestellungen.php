<?php
require_once 'vendor/autoload.php';

$servername = "w014060b.kasserver.com";
$username   = "d03d2f58";
$password   = "P1r2i3n4z5";
$dbname     = "d03d2f58";

$conn       = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);

$name = $_POST['name'];

$select = $conn->prepare("SELECT cocktail, count(cocktail) as anzahl, preis FROM bestellungen WHERE name = '$name' GROUP BY cocktail");
$select->execute();
$cocktails = $select->fetchAll(PDO::FETCH_ASSOC);

$data = array();

foreach($cocktails as $position) {
    $cocktail = $position['cocktail'];
    $anzahl = $position['anzahl'];
    $preis = $position['preis'] * $position['anzahl'];

    $data[$cocktail]['anzahl']   = $anzahl;
    $data[$cocktail]['preis']    = $preis;
}

echo json_encode($data);