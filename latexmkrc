$latex = 'uplatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S';
#$pdflatex = 'pdflatex %O -synctex=1 %S';
#$lualatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx -f noto.map %O -o %D %S';
#$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
#$ps2pdf = 'ps2pdf %O %S %D';
$max_repeat = 3;
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
if ($^O eq 'darwin') {
    $pdf_previewer = 'open -ga /Applications/Skim.app';
} elsif ($^O eq 'linux') {
    $pdf_previewer = 'xdg-open';
}
