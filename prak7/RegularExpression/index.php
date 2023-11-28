<?php

$htmlText = '<p> Apa genre musik favoritmu? <br/> <span style="text-decoration: underline;;"> Indie </span> atau <span style="text-decoration: underline;"> Country </span> ... </p>';

$regex = '/<span style="text-decoration:\s*([^"]+)">/';

$newTxtDec = 'overline';

$newHTMLText = preg_replace($regex, 'span style="text-decoration : '. $newTxtDec . ';">', $htmlText);

echo $newHTMLText;
?>