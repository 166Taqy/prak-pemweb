<?php
class Mahasiswa{
    public $nim;
    public $nama;
    public $prodi;
    public $usia;

    public function __construct($nim, $nama, $prodi, $usia){
        $this->nim = $nim;
        $this->nama = $nama;
        $this->prodi = $prodi;
        $this->usia = $usia;
    }

    public function getMahasiswa(){
        echo "NIM : ".$this->nim. "<br> Nama : ".$this->nama. "<br> Prodi : ".$this->prodi. "<br> Usia : ".$this->usia. "<br> <br>";
    }
}

$mhs1 = new Mahasiswa(121140165,"Fadel Malik","Teknik Informatika", 20);
$mhs2 = new Mahasiswa(121140166,"Muhammad Taqy Abdullah","Teknik Informatika", 21);

$mhs1 -> getMahasiswa();
$mhs2 -> getMahasiswa();

class Valorant extends Mahasiswa{
    public $rank;
    public $kd;

    public function __construct($nim, $nama, $prodi, $usia, $rank, $kd){
        parent::__construct($nim, $nama, $prodi, $usia,);
        $this->rank = $rank; 
        $this->kd = $kd; 
    }

    public function getMhsVal(){
        echo "NIM : ".$this->nim. "<br> Nama : ".$this->nama. "<br> Prodi : ".$this->prodi. "<br> Usia : ".$this->usia. "<br> Rank : ".$this->rank. "<br> KD : ".$this->kd ."<br> <br>";
    }

}

$pemainMhs1 = new Valorant(12111123,"Doni","Teknik Pertambangan",20, "Bronze", 1);

$pemainMhs1 -> getMhsVal();

class dataPrivat{
    public $Nama;
    private $tahunLahir;

    public function __construct($Nama, $tahunLahir){
        $this->settahunLahir($tahunLahir);
        $this->Nama = $Nama;
    }

    public function settahunLahir($tahunLahir){
        if(is_string($tahunLahir) && strlen($tahunLahir) > 0){
            $this->tahunLahir = $tahunLahir;
        } else {
            throw new InvalidArgumentException("Anda harus mengisi tahun lahir");
        }
    }

    public function getTahunLahir(){
        return "Nama : ".$this->Nama. "\nTahun Lahir : ".$this->tahunLahir. "<br>";
    }
}

try {
    $test = new dataPrivat("Yeshua", 1999);
    $test->settahunLahir(2000);
    echo $test->getTahunLahir();
}catch(InvalidArgumentException $e){
    echo "Terdapat error pada penginputan nama dan tahun lahir. Berikut merupakan laporan error : ". $e->getMessage(). "<br> <br>";
}

$htmlText = '<p> Hello there, what is your favorite music genre out of these 3? <br> <span style="text-decoration: underline;"> Hip Hop </span> atau <span style="text-decoration: underline;"> Pop </span> </p>';

echo "kalimat HTML sebelum diberi regular expression : ";
echo $htmlText;
$regex = '/<span style="text-decoration:\s*([^"]+)">/';

$newTxtDec = 'overline';

$newHTMLText = preg_replace($regex, '<span style="text-decoration : '. $newTxtDec . ';">', $htmlText);
echo "kalimat HTML setelah diberi regular expression : ";
echo $newHTMLText;

?>