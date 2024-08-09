# Instruções gerais </br>
 </br>
## Para que serve o arquivo "POkeDIO.sol"? </br>
 </br>
O arquivo "POkeDIO.sol" simula uma batalha Pokemon em que são queimados ETH durante as batalhas.</br>
 </br>
## Pré-rquisitos </br>
 </br>
| Aplicativo | Tipo      | Função                                                   |
|------------|-----------|----------------------------------------------------------|
| Ganache    | Programa  | Criar carteiras ETH virtuais                             |
| IPFS       | Programa  | Criar um identificador dos baseado nas imagens utilizadas|
| Metamask   | Extensão  | Sincronizar as carteiras                                 |
| Remix IDE  | Site      | Compila o contrato e executa o contrato na blockchain ETH|
 </br>
## Como usar o arquivo "POkeDIO.sol"? </br>
 </br>
Inicialmente, os programas deverão estar instalados. </br>
1. No Ganache, será gerada uma nova Workplace, onde serão geradas 10 contas virtuais contendo 100 ETH. </br>
2. No Metamask, as carteiras geradas pelo Ganache serão importadas. Mas basta importar DUAS. </br>
3. Copie e cole o arquivo "POkeDIO.sol" na Remix IDE. </br>
4. Importe as imagens dos seus pokemons usando o IFPS. Nele, você gerará um identificado único que será usado na Remix IDE para gerar os pokemons. </br>
5. Após compilar o arquivo "POkeDIO.sol", você irá interagir com o contrato criando seu pokemon em "createNewPokemon", onde há 3 variáveis: </br> 
</br>
| Variável       | Descrição                          | Definição              |
|----------------|------------------------------------|------------------------|
| _name          | define o nome do pokemom           | Definido pelo usuário  |
| _to            | chave pública do dono da carteira  | Definido pelo Metamask |
| _imagem        | string oriunda do endereço na IPFS | Definido pela IFPS     |
</br>
Ao se criar um pokemon, serão consumidos PokeDIOs, seráaberta uma mensagem no Metamask solicitando a autorização da transação.</br>
A segunda conta é adicionada para ser o oponente, também se seguem os mesmos passos para criação de pokemon.</br>
</br>
## Resultados </br>
 </br>
Ocorrerá uam batalha pokemom que irá consumir ETH da carteira A ou da carteira B, uma vez que cada batalha faz uma call de um smat contract, que conseome gás. </br>
