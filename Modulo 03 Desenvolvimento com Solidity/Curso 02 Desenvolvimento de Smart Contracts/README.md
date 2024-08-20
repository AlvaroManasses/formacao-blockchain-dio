
# DIOCoin - Um Token ERC20 Básico

Este repositório contém um contrato Solidity que implementa um token ERC20 básico chamado DIOCoin. O DIOCoin é um token fungível que segue o padrão ERC20, com algumas funções principais que permitem transferências, aprovações, e consultas de saldos e permissões.

## Funcionalidades Principais

1. **totalSupply()**: Retorna a quantidade total de tokens em circulação.
2. **balanceOf(address)**: Retorna o saldo de tokens de uma conta específica.
3. **transfer(address, uint256)**: Transfere uma quantidade de tokens para um destinatário.
4. **approve(address, uint256)**: Permite que uma conta gaste uma quantidade específica de tokens em nome do remetente.
5. **allowance(address, address)**: Retorna a quantidade de tokens que um 'spender' pode gastar da conta 'owner'.
6. **transferFrom(address, address, uint256)**: Transfere tokens de uma conta para outra usando a permissão concedida.

## Como Funciona

- **Construtor**: Ao implantar o contrato, todos os tokens são atribuídos ao endereço que implanta o contrato.
- **Transferência de Tokens**: Os tokens podem ser transferidos entre contas usando a função `transfer`.
- **Aprovações e Permissões**: Uma conta pode aprovar outra conta para gastar tokens em seu nome usando `approve`. A função `allowance` permite verificar quantos tokens uma conta foi aprovada para gastar.
- **Transferência com Permissão**: Tokens podem ser transferidos de uma conta para outra usando a função `transferFrom`, desde que a conta que realiza a transferência tenha a devida permissão.

## Considerações de Uso

Este contrato pode ser utilizado como base para a criação de tokens em uma rede Ethereum. Ele é um exemplo simples e básico que pode ser expandido para incluir funcionalidades mais complexas, como queima de tokens, emissão de novos tokens, e restrições de transferência.

---

## Código Solidity Explicado

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Criação da interface para um token ERC20
interface IERC20{

    // Função para obter o total de tokens em circulação
    function totalSupply() external view returns (uint256);

    // Função para verificar o saldo de tokens de uma conta específica
    function balanceOf(address account) external view returns (uint256);

    // Função para verificar a quantidade de tokens que um 'spender' pode gastar da conta 'owner'
    function allowance(address owner, address spender) external view returns (uint256);

    // Função para transferir tokens para outra conta
    function transfer(address recipient, uint256 amount) external returns (bool);

    // Função para aprovar que um 'spender' possa gastar uma quantidade específica de tokens
    function approve(address spender, uint256 amount) external returns (bool);

    // Evento que é emitido quando tokens são transferidos de uma conta para outra
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Evento que é emitido quando uma aprovação é feita para que um 'spender' gaste tokens
    event Approval(address indexed owner, address indexed spender, uint256);
}

// Implementação do contrato DIOCoin, que é um token ERC20
contract DIOCoin is IERC20{

    // Nome do token
    string public constant name = "DIOCoin";

    // Símbolo do token
    string public constant symbol = "DIO";

    // Número de casas decimais usadas pelo token
    uint8 public constant decimals = 18;

    // Mapeamento que armazena os saldos dos endereços
    mapping (address => uint256) balances;

    // Mapeamento que armazena as permissões de gasto entre contas
    mapping(address => mapping(address=>uint256)) allowed;

    // Quantidade total de tokens em circulação
    uint256 totalSupply_ = 10 ether;

    // Construtor que atribui todos os tokens ao criador do contrato
    constructor(){
        balances[msg.sender] = totalSupply_;
    }

    // Função que retorna o total de tokens em circulação
    function totalSupply() public override view returns (uint256){
        return totalSupply_;
    }
    
    // Função que retorna o saldo de tokens de um determinado endereço
    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

    // Função para transferir tokens do remetente para outro endereço
    function transfer(address receiver, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[msg.sender]); // Verifica se o remetente tem tokens suficientes
        balances[msg.sender] = balances[msg.sender]-numTokens; // Deduz os tokens do saldo do remetente
        balances[receiver] = balances[receiver]+numTokens; // Adiciona os tokens ao saldo do destinatário
        emit Transfer(msg.sender, receiver, numTokens); // Emite o evento de transferência
        return true;
    }

    // Função para aprovar que outra conta gaste uma quantidade específica de tokens em nome do remetente
    function approve(address delegate, uint256 numTokens) public override returns (bool){
        allowed[msg.sender][delegate] = numTokens; // Define a permissão
        emit Approval(msg.sender, delegate, numTokens); // Emite o evento de aprovação
        return true;
    }

    // Função para verificar quantos tokens um 'spender' está autorizado a gastar da conta 'owner'
    function allowance(address owner, address delegate) public override view returns (uint256){
        return allowed[owner][delegate];
    }

    // Função para transferir tokens de uma conta para outra, usando a permissão concedida
    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[owner]); // Verifica se o 'owner' tem tokens suficientes
        require(numTokens <= allowed[owner][msg.sender]); // Verifica se o 'spender' tem permissão suficiente

        balances[owner] = balances[owner]-numTokens; // Deduz os tokens do saldo do 'owner'
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens; // Reduz a permissão do 'spender'
        balances[buyer] = balances[buyer]+numTokens; // Adiciona os tokens ao saldo do comprador
        emit Transfer(owner, buyer, numTokens); // Emite o evento de transferência
        return true;
    }
}
```

