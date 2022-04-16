#!/bin/bash
#
# criarAmbienteBabel.sh - Cria um ambiente Babel no seu projeto node.js
#
# Site: https://github.com/RuanOlive
# Autor: Ruan Oliveira Sarmento <ruansarmento732@gmail.com>
# ------------------------------------------------------------------------
# Este programa cria e instala os arquivos necessarios no seu projeto node.js 
# para que você possa usar o babel.
# -------------------------------------------------------------------------
#
# Histórico: 
#
#       v1.0 15-04-2022, Ruan Oliveira:
#
# Licença: MIT.
echo "Criando Projeto Babel no diretório atual..."
npm i @babel/core @babel/cli @babel/preset-env -D
touch .babelrc
echo "{
    \"presets\": [\"@babel/preset-env\"]
}" > .babelrc

echo "Finalizado."