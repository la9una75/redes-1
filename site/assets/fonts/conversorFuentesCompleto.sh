#!/bin/bash

# Conversión de fuentes desde
# https://github.com/google/fonts


# Todas las fuentes en directorio actual e hijos
FUENTES=$(find . -type f -name '*.ttf')

# Convirtiendo fuentes .ttf a .eot
# https://github.com/fontello/ttf2eot
echo "Conviertiendo TTF a EOT"; 
sleep 1

for afile in $FUENTES
do
	output=${afile:0:(-3)}eot
	echo convert from $afile to $output
	ttf2eot $afile $output
done

# Convirtiendo fuentes .ttf a .woff
# https://github.com/fontello/ttf2woff
echo "Conviertiendo TTF a WOFF"; 
sleep 1

for font in $FUENTES
do 
	ttf2woff -t woff $font $font.woff 
done

# Convirtiendo ttf a woff2
# https://github.com/google/woff2
echo "Conviertiendo TTF a WOFF2"; 
sleep 1

for font in $FUENTES
do 
	woff2_compress $font
done


# Eliminando todos los archivos que no sean fuentes
find . -type f ! -name "*.ttf" ! -name "*.woff" ! -name "*.woff2" ! -name "*.eot" ! -name "*.sh" -exec rm {} \;

# Copiando las fuentes a una carpeta
find . -name "*.ttf" -name "*.woff" -name "*.eot" -name "*.woff2" -exec cp {}  fuentesOK \;

# Eliminando carpetas vacías
find . -depth -type d -empty -exec rmdir {} \;