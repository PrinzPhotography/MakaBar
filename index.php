<?php

session_start();

require_once 'smarty/libs/Smarty.class.php';
require_once 'vendor/autoload.php';

$smarty = new Smarty();
$smarty->setTemplateDir('MakarBar');
$smarty->setCompileDir('C:\tmp');

$servername = "w014060b.kasserver.com";
$username   = "d03d2f58";
$password   = "P1r2i3n4z5";
$dbname     = "d03d2f58";

$conn       = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);

//Cocktails sammeln
$select = $conn->prepare("SELECT * FROM cocktails WHERE alkohol = 'Y'");
$select->execute();
$cocktails = $select->fetchAll(PDO::FETCH_ASSOC);


$zutaten = array();
$cocktailliste = array();

foreach($cocktails as $cocktail) {
    $zutatenliste = explode(",", $cocktail["zutaten"]);
    foreach($zutatenliste as $zutat) {
        $cocktailliste[$cocktail['name']]['Zutaten'][] = utf8_encode($zutat);
    }
    $cocktailliste[$cocktail['name']]['Preis'][] = $cocktail['preis'];
}

$smarty->assign('cocktails', $cocktailliste);
$smarty->display('index.tpl');




