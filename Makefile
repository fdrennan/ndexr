help:
	echo "https://makefiletutorial.com/"

run: format
	Rscript "styler::style_file('main.R')"
