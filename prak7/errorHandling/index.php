<?php 

require 'MusicError.php';

try {
    $music1 = new MusicError("Ular berbisa");

    $music1 -> setTitle(1010);    
} catch (InvalidArgumentException $e) {
    echo "Kesalahan: ". $e->getMessage() ."<br>";
}
?>
