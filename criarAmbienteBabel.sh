#!/bin/bash
#
# criarAmbienteBabel.sh - Cria um ambiente Babel/WebPack no seu projeto node.js
#
# Site: https://github.com/RuanOlive
# Autor: Ruan Oliveira Sarmento <ruansarmento732@gmail.com>
#
#------------------------------------------------------------------------
# Este programa cria e instala os arquivos necessarios no seu projeto node.js 
# para que você possa usar o babel.
#-------------------------------------------------------------------------
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
#
#       v2.1 20-04-2022, Ruan Oliveira:
#           - Adicionada a criação do sourceMapFileName. 
#           - Arrumado o Bug do script de build.
#
#       v3.0 24-04-2022-Stable, Ruan Oliveira:
#           - Código Totalmente Refatorado.
#           - Adicionada Nova Configuração do WebPack5 e Babel.
#           - Removida a instalação de node modules Deprecated.
#           - Versão Stable(Estável) do script.
#
# Licença: MIT.

# Verifica se o arquivo package.json existe.
if [[ -e ./package.json ]]; then
    echo "Criando Projeto Babel/WebPack no diretório atual..."

    #--------Instalação de dependencias--------

    # WebPack
    npm i webpack --save-dev

    # Permite usar WebPack no terminal
    npm i webpack-cli --save-dev

    # Serve para criar um servidor de desenvolvimento
    npm i webpack-dev-server --save-dev

    # Babel
    npm install babel-loader @babel/core --save-dev 
    npm install @babel/preset-env --save-dev

    #-------Adicionando Scripts no package.json-------

    # Em desenvolvimento usaremos o comando "npm run dev".
    sed -i "/"scripts"/a\    \"dev\":\"webpack-dev-server --mode=development \", " package.json 
    
    # Em produção usaremos o comando "npm run build".
    sed -i "/"scripts"/a\    \"build\":\"webpack --mode=production \", " package.json 

    #--------Criando arquivos--------

    # Cria a estrutura de arquivos básica do seu projeto.
    mkdir ./public
    touch ./public/index.html
    mkdir ./src
    touch ./src/main.js

    # Cria o arquivo de configuração do WebPack.
    touch ./webpack.config.js

    # Cria o arquivo de configuração do Babel.
    touch ./babel.config.json

    # Escreve todas as configurações necessárias dentro do arquivo de 
    # configuração do Babel.
    echo "{
  \"presets\": [\"@babel/preset-env\"]
}" > ./babel.config.json

    # Escreve todas as configurações necessárias dentro do arquivo de 
    # configuração do WebPack.
    echo "
const path = require('path');

module.exports = {
  entry: './src/main.js',
  mode: 'development',
  output: {
    path: path.resolve(__dirname, './public/'),
    filename: 'bundle.js',
  },
  module: {
    rules: [{ 
      test: /\.m?js$/,
      exclude: /node_modules/,
      use: {
        loader: 'babel-loader',
        options: {
          presets: ['@babel/preset-env']
        }
      }
    }],
  }
};" > webpack.config.js


    echo "Finalizado, execute npm run dev, para rodar o ambiente de 
    desenvolvimento ou npm run build para criar o bundle.js ."
else
    echo "O arquivo package.json não existe!, Execute npm init para criar um 
    projeto node.js"
    exit
fi
