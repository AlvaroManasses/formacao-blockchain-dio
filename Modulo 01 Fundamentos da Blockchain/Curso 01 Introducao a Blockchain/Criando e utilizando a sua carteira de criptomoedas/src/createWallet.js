// Importando as dependências necessárias para a geração e manipulação de carteiras Bitcoin
const bip32 = require('bip32')  // Biblioteca para trabalhar com carteiras HD (Hierarchical Deterministic)
const bip39 = require('bip39')  // Biblioteca para geração e manipulação de frases mnemônicas (seed)
const bitcoin = require('bitcoinjs-lib')  // Biblioteca principal para manipulação de endereços e transações Bitcoin

// Definindo a rede que será usada (testnet para testes, ou mainnet para transações reais)
// Aqui estamos configurando para a rede de teste (testnet)
const network = bitcoin.networks.testnet
// Para a rede principal (mainnet), descomente a linha abaixo e comente a anterior
// const network = bitcoin.networks.bitcoin

// Definindo o caminho de derivação para carteiras HD
// Este caminho segue o padrão BIP49 para P2SH (Pay-to-Script-Hash) e está configurado para a testnet
const path = `m/49'/1'/0'/0` 
// Para a mainnet, use o caminho abaixo
// const path = `m/49'/0'/0'/0`

// Gerando a frase mnemônica (seed) que será usada para criar a carteira
let mnemonic = bip39.generateMnemonic()  // Gera uma nova frase mnemônica aleatória
const seed = bip39.mnemonicToSeedSync(mnemonic)  // Converte a frase mnemônica em uma seed binária

// Criando a raiz da carteira HD a partir da seed gerada
let root = bip32.fromSeed(seed, network)  // Cria a raiz da carteira HD usando a seed e a rede selecionada

// Derivando uma conta (conjunto de chaves públicas e privadas) a partir da raiz da carteira
let account = root.derivePath(path)  // Deriva o caminho especificado na árvore de chaves
let node = account.derive(0).derive(0)  // Deriva uma chave específica (primeira conta, primeira chave)

// Criando o endereço Bitcoin a partir da chave pública gerada
let btcAddresss = bitcoin.payments.p2pkh({
    pubkey: node.publicKey,  // Define a chave pública
    network: network,  // Define a rede (testnet)
}).address

// Exibindo informações da carteira gerada
console.log("Carteira gerada")
console.log("Endereço: ", btcAddresss)  // Exibe o endereço Bitcoin gerado
console.log("Chave privada:", node.toWIF())  // Exibe a chave privada em formato WIF (Wallet Import Format)
console.log("Seed", mnemonic)  // Exibe a frase mnemônica gerada (importante para recuperação da carteira)
