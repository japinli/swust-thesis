$pdflatex = "xelatex %O %S";
$pdf_mode = 1;
$makeindex = 'makeindex -s gind.ist %O -o %D %S';
$clean_ext = 'fls glo hd ind ilg out idx log bbl gls';
add_cus_dep('glo', 'gls', 0, 'makegls');
sub makegls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}
