<?php
class videogame {
    public $title;
    public $developers;
    public $genre;
    public $release;

    public function __construct($title, $developers, $genre, $release) {
        $this->title = $title;
        $this->developers = $developers;
        $this->genre = $genre;
        $this->release = $release;
        echo "Game Object has been made. <br>";
    }

    public function getTitle() {
        echo "Videogame : ".$this->title. " <br> Developer : ".$this->developers. " <br> Genre : ".$this->genre. " <br> Release year : ".$this->release. " <br> ";
    }

    public function __destruct() { 
        echo "Game objects have been terminated! ";
    }
}

$game1 = new videogame("Dota 2", "Valve", "MOBA", 2014);
$game1->getTitle();

?> 