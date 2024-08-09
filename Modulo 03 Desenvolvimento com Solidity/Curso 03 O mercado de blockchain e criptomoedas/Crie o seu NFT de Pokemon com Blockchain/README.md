<h1> Instruções gerais </h1>
 </br>
<h2> Para que serve o arquivo "POkeDIO.sol"? </h2>
 </br>
O arquivo "POkeDIO.sol" simula uma batalha Pokemon em que são queimados ETH durante as batalhas.</br>
 </br>
<h2> Pré-requisitos </h2>
 </br>
1. O Ganache é um programa que será usado para criar carteiras ETH virtuais; </br>
2. O IPFS é um programa que será usado para criar um identificador dos baseado nas imagens utilizadas; </br>
3. O Metamask é uma Extensão do Chrome que será usado para sincronizar as carteiras; </br>
4. O Remix IDE é um site que será usado para compilar o contrato e executar o contrato na blockchain ETH;  </br>
 </br>
<h2> Como usar o arquivo "POkeDIO.sol"? </h2>
 </br>
Inicialmente, os programas deverão estar instalados. </br>
1. No Ganache, será gerada uma nova Workplace, onde serão geradas 10 contas virtuais contendo 100 ETH. </br>
2. No Metamask, as carteiras geradas pelo Ganache serão importadas. Mas basta importar DUAS. </br>
3. Copie e cole o arquivo "POkeDIO.sol" na Remix IDE. </br>
4. Importe as imagens dos seus pokemons usando o IFPS. Nele, você gerará um identificado único que será usado na Remix IDE para gerar os pokemons. </br>
5. Após compilar o arquivo "POkeDIO.sol", você irá interagir com o contrato criando seu pokemon em "createNewPokemon", onde há 3 variáveis: </br> 
</br>
A variável '_name' define o nome do pokemom , que é definida pelo usuário; </br> 
A variável '_to' declara a chave pública do dono da carteira, que é definida pelo Metamask; </br> 
A variável '_imagem' é a string oriunda do endereço na IPFS, que é definido pela IFPS; </br> 
</br>
Ao se criar um pokemon, serão consumidos PokeDIOs, seráaberta uma mensagem no Metamask solicitando a autorização da transação.</br>
A segunda conta é adicionada para ser o oponente, também se seguem os mesmos passos para criação de pokemon.</br>
</br>
<h2> Resultados </h2>
 </br>
Ocorrerá uam batalha pokemom que irá consumir ETH da carteira A ou da carteira B, uma vez que cada batalha faz uma call de um smat contract, que consome gás. </br>
