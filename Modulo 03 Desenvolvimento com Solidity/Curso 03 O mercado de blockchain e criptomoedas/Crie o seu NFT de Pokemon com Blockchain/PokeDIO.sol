// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// Importa a implementação do padrão ERC721 da OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Declaração do contrato PokeDIO que herda a funcionalidade do contrato ERC721
contract PokeDIO is ERC721 {

    // Estrutura que define as propriedades de um Pokémon
    struct Pokemon {
        string name; // Nome do Pokémon
        uint level;  // Nível do Pokémon
        string img;  // URL da imagem do Pokémon
    }

    // Array público que armazena todos os Pokémons criados
    Pokemon[] public pokemons;

    // Endereço do dono do jogo
    address public gameOwner;

    // Construtor que define o nome e símbolo do token ERC721 e atribui o dono do jogo
    constructor() ERC721("PokeDIO", "PKD") {
        gameOwner = msg.sender; // O dono do contrato é quem o implanta
    }

    // Modificador que garante que apenas o dono de um Pokémon possa realizar certas ações
    modifier onlyOwnerOf(uint _monsterId) {
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode batalhar com este Pokemon");
        _;
    }

    // Função que permite que um Pokémon ataque outro em batalha
    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon) {
        // Referências aos Pokémons atacantes e defensores
        Pokemon storage attacker = pokemons[_attackingPokemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

        // Lógica de batalha: o nível do atacante e defensor são ajustados conforme o resultado da batalha
        if (attacker.level >= defender.level) {
            attacker.level += 2; // O atacante ganha 2 níveis se vencer
            defender.level += 1; // O defensor ganha 1 nível mesmo se perder
        } else {
            attacker.level += 1; // O atacante ganha 1 nível se perder
            defender.level += 2; // O defensor ganha 2 níveis se vencer
        }
    }

    // Função para criar um novo Pokémon, somente o dono do jogo pode fazer isso
    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Pokemons");
        uint id = pokemons.length; // O ID do novo Pokémon é a posição dele no array
        pokemons.push(Pokemon(_name, 1, _img)); // Adiciona o novo Pokémon ao array, começando no nível 1
        _safeMint(_to, id); // Realiza o minting seguro do token ERC721 para o endereço fornecido
    }
}
