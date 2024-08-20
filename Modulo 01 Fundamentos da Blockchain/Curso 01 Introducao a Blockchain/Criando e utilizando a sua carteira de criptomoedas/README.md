# Script para Geração de Carteira Bitcoin HD na Testnet

Este repositório contém um script em JavaScript que, juntamente com a carteira de Bitcoin [Electrum](https://electrum.org/#download), permite a geração de uma carteira Bitcoin HD (Hierarchical Deterministic) na rede de testes (testnet).

## Pré-requisitos

Antes de executar o script, certifique-se de que o Node.js está instalado e que as dependências abaixo foram configuradas:

```bash
npm install bip32 bip39 bitcoinjs-lib
```

Além disso, é necessário ter a carteira [Electrum](https://electrum.org/#download) instalada para realizar a importação da carteira gerada.

## Funcionamento do Script

O script realiza as seguintes etapas:

1. **Importação das Dependências**:
   - As bibliotecas `bip32`, `bip39` e `bitcoinjs-lib` são importadas para manipulação de carteiras HD, geração de frases mnemônicas e criação de endereços Bitcoin.

2. **Definição da Rede**:
   - A rede é configurada para `testnet`, utilizada para testes. Para gerar uma carteira na rede principal (mainnet), altere a variável `network` para `bitcoin.networks.bitcoin`.

3. **Definição do Caminho de Derivação**:
   - O caminho de derivação segue o padrão BIP49 para carteiras HD compatíveis com endereços P2SH. Na testnet, utiliza-se `m/49'/1'/0'/0`. Para a mainnet, utilize `m/49'/0'/0'/0`.

4. **Geração da Frase Mnemônica (Seed)**:
   - Uma frase mnemônica é gerada aleatoriamente e convertida em uma seed binária. Esta seed é a base para a criação da carteira HD.

5. **Criação da Raiz da Carteira HD**:
   - A seed é utilizada para criar a raiz da carteira HD, a partir da qual são derivadas as chaves públicas e privadas.

6. **Derivação de uma Conta**:
   - Uma conta é derivada a partir da raiz da carteira seguindo o caminho de derivação especificado.

7. **Criação do Endereço Bitcoin**:
   - A partir da chave pública derivada, o script gera um endereço Bitcoin compatível com a rede configurada.

8. **Exibição das Informações da Carteira**:
   - O script exibe o endereço Bitcoin gerado, a chave privada em formato WIF e a frase mnemônica.

## Importação na Carteira Electrum

Após gerar a carteira com o script, siga os passos abaixo para importar a carteira na Electrum:

```console
# Abra a Electrum
# Inicie a carteira Electrum e escolha a opção de criar uma nova carteira.

# Selecione 'Carteira Padrão'
# Escolha a opção "Carteira Padrão" na configuração da nova carteira.

# Importe a Frase Mnemônica
# No passo onde é solicitado a frase de recuperação, insira a frase mnemônica gerada pelo script.

# Configure o Caminho de Derivação
# Se necessário, configure o caminho de derivação. Para a testnet, use `m/49'/1'/0'/0`.
# Para a mainnet, use `m/49'/0'/0'/0`.

# Conclua a Configuração
# Siga as instruções até concluir a configuração. A carteira gerada pelo script será importada para a Electrum.
```

## Execução do Script

Para executar o script, utilize o seguinte comando:

```console
$ node script.js
```

## Exemplo de Saída

Após a execução do script, a saída será semelhante a esta:

```console
Carteira gerada
Endereço: 2N3JfRbq7Pv5F77Mx5rff2vD8JbxH5xPBES
Chave privada: cT5QqsiPM8uKjTgxyXTN5A4yoGn8Hs29KbM6SkF5e8sUHsBtY4ek
Seed: pigeon vivid vibrant solve door autumn enrich tired fence arena bind faculty
```

> **Nota**: Guarde a frase mnemônica em um local seguro, pois ela é necessária para recuperar sua carteira na Electrum.

## Alterando para a Rede Principal

Para usar o script na rede principal (mainnet), altere a variável `network` para `bitcoin.networks.bitcoin` e o caminho de derivação para `m/49'/0'/0'/0`. Lembre-se de que qualquer valor transferido na mainnet é real e irreversível.

```javascript
// Para a mainnet
const network = bitcoin.networks.bitcoin
const path = `m/49'/0'/0'/0`
```

## Considerações Finais

Este script é uma ferramenta básica para gerar carteiras Bitcoin HD e importá-las na Electrum. Para usos em produção ou com valores reais, recomenda-se um estudo mais aprofundado das melhores práticas de segurança e armazenamento seguro das chaves privadas e frases mnemônicas.
