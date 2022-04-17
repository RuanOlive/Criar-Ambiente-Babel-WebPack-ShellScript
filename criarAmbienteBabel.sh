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
#           - Versão inicial, cria estrutura básica do Babel sem o Webpack.
#
#       v2.0 16-04-2022, Ruan Oliveira:
#           - Adiciona a Verificação se existe o package.json
#           - Adiciona a instalação do WebPack.
#           - Cria uma estrutura de arquivos básica para o seu projeto.
#           - Cria o script dev para executar o webpack-dev-server no seu projeto.
#           - Cria o script build para executar o build do seu projeto.
#           - Adiciona tratamento de erros.

# Licença: MIT.

#Verifica se o arquivo package.json existe.
if [[ -e ./package.json ]]; then
    echo "Criando Projeto Babel/WebPack no diretório atual..."

    # Instala o Webpack e o Babel no seu projeto Node.js
    npm i webpack webpack-cli @webpack-cli/serve webpack-dev-server @babel/polyfill --save-dev

    # Cria a estrutura de arquivos básica do seu projeto.
    mkdir ./public
    mkdir ./src
    touch ./public/bundle.js
    touch ./public/index.html
    touch ./src/main.js

    # Cria o aquivo de configuração do WebPack.
    touch webpack.config.js

    # Escreve todas as configurações necessárias dentro do arquivo de 
    # configuração do WebPack.
    echo "const path = require('path')

module.exports = {
    entry: ['@babel/polyfill', path.resolve(__dirname, './src/main.js')],
    mode: 'development',
    output: {
        path: path.resolve(__dirname, './public'),
        filename: 'bundle.js'
    },
    devServer: {
        static: {
            directory: path.join(__dirname, './public'),
        },
        compress: true,
        port: 9000,
    },
    devtool: 'source-map'
}
    " > webpack.config.js

    # Insere o script dev no package.json
    sed -i "/"scripts"/a\    \"dev\":\"webpack serve --mode=development \", " package.json 
    # Insere o script build no package.json
    sed -i "/"scripts"/a\    \"build\":\"webpack serve --mode=production \", " package.json 
    
    echo "Finalizado, execute npm run dev, para rodar o ambiente de 
    desenvolvimento ou npm run build para o ambiente de produção."
else
    echo "O arquivo package.json não existe!, Execute npm init para criar um 
    projeto node.js"
    exit
fi
