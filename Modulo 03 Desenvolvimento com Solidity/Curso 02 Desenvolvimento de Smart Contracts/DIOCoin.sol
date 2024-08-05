// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//cria interface
interface IERC20{

    function totalSupply() external view returns (uint256); //Define o Suplly total do Token gerado

    function balanceOf(address account) external view returns (uint256);  //Verifica a quantidade

    function allowance(address owner, address spender) external view returns (uint256); // Permissão para terceiros gastarem usando tokens da conta proprietária

    function transfer(address recipient, uint256 amount) external returns (bool); //Confirma o valor a ser transferido

    function approve(address spender, uint256 amomunt) external returns (bool); //Aprovar o gasto

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256);

}

contract DIOCoin is IERC20{

    string public constant name = "DIOCoin"; //Define o nomn do token
    string public constant symbol = "DIO"; //Define o símbolo do Token
    uint8 public constant decimals = 18; // Define a quantidade de casas decimais

    mapping (address => uint256) balances;

    mapping(address => mapping(address=>uint256)) allowed; //quais endereços podem gaster e quanto

    uint256 totalSupply_ = 10 ether; //define o total disponível para gastar

    constructor(){
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256){
        return totalSupply_;
    }
    
    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

//função de transferencia de tokens

    function transfer(address receiver, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender]-numTokens;
        balances[receiver] = balances[receiver]+numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

//função aprovação
    function approve(address delegate, uint256 numTokens) public override returns (bool){
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

//função permissão
    function allowance(address owner, address delegate) public override view returns (uint){
        return allowed[owner][delegate];
    }

//função trasnferência
    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner]-numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens;
        balances[buyer] = balances[buyer]+numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
