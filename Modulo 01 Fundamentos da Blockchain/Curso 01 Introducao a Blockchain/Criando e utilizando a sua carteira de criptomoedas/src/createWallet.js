//importando as dependencias
const bip32 = require('bip32')
const bip39 = require('bip39')
const bitcoin = require('bitcoinjs-lib')

//definir a rede
const network = bitcoin.networks.testnet // configura a rede para teste
//const network = bitcoin.networks.bitcoin configura a rede para principal

//derivação de carteiras HD
const path = `m/49'/1'/0'/0` // caminho na testnet
//const path = `m/49'/0'/0'/0` // caminho na mainnet

//criando o mnemonic para a seed (palavras de senha)
let mnemonic = bip39.generateMnemonic()
const seed = bip39.mnemonicToSeedSync(mnemonic)

//criando a raiz da carteira HD
let root = bip32.fromSeed(seed, network)

//criando uma conta - par private-public keys
let account = root.derivePath(path)
let node = account.derive(0).derive(0)

let btcAddresss = bitcoin.payments.p2pkh({
    pubkey: node.publicKey,
    network: network,
}).address

console.log("Carteira gerada")
console.log("Endereço: ", btcAddresss)
console.log("Chave privada:", node.toWIF()) // exibe no formato usado pelo nosso gerenciador de carteiras
console.log("Seed", mnemonic)


