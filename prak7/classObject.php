<?php

class Mobil {
    public $merk;
    public $tahun;
    public $warna;
    public function infomobil(){
        echo "Mobil ".$this->merk. " tahun ".$this->tahun. " berwarna ".$this->warna. " . ";
    }
}

$mobil1 = new Mobil();
$mobil1->merk = "Avanza";
$mobil1->tahun = "2020";
$mobil1->warna = "Hitam";

$mobil1->infomobil();
?>