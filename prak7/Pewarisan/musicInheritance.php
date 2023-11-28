<?php

class Music {
    public $title;
    public $artist;
    public $genre;

    public function __construct($title, $artist, $genre){
        $this->title = $title;
        $this->artist = $artist;
        $this->genre = $genre;
    }
    
    public function infoMusic() {
        echo"title : ".$this->title. " artist : ".$this->artist. " genre : ".$this->genre. " .<br>";
    }
}
?>