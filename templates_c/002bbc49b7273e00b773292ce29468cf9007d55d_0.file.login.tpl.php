<?php
/* Smarty version 4.3.0, created on 2023-06-01 19:44:27
  from 'C:\Users\aprin\PhpstormProjects\MakarBar\login.html' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.0',
  'unifunc' => 'content_6478f51b8d5745_93890739',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '002bbc49b7273e00b773292ce29468cf9007d55d' => 
    array (
      0 => 'C:\\Users\\aprin\\PhpstormProjects\\MakarBar\\login.html',
      1 => 1685646646,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6478f51b8d5745_93890739 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Makabar - Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
  <div class="container">
    <form method="post" action="login.php">
      <h2>Login</h2>
      <label for="username">Benutzername:</label>
      <input type="text" name="username" id="username" required><br>

      <label for="password">Passwort:</label>
      <input type="password" name="password" id="password" required><br>

      <input type="submit" value="Einloggen">
    </form>
  </div>
</body>
</html><?php }
}
