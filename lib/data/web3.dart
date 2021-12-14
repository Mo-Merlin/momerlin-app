// Package From Global
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:hex/hex.dart';

// Package From Pub.dev

import 'package:web3dart/web3dart.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;

const mainnet = "https://mainnet.infura.io/v3/21485433cdfb42388fbfe0f5da415eae";
const testnet = "https://rinkeby.infura.io/v3/21485433cdfb42388fbfe0f5da415eae";
// static const private = "http://167.172.136.219:8545";
// static const private = "http://3.142.213.84:8545";
const private = "http://18.142.27.152:7545";
const private1 = "http://gpgrpc.smartchain.in:8545";
// var httpClient = new Client();
// var ethClient = new Web3Client(mainnet, httpClient);

var ethClientbsc = new Web3Client(testnet, httpClient);

// final mainnet = Config.mainnet;
// final testnet = Config.testnet;
// final private = Config.private;

final httpClient = new Client();
final Web3Client ethClient = new Web3Client(mainnet, httpClient);
final Web3Client ethClientMain = new Web3Client(mainnet, httpClient);
final Web3Client ethClientTest = new Web3Client(testnet, httpClient);
final Web3Client ethClientPrivate = new Web3Client(private, httpClient);

final Web3Client ethClientPrivate1 = new Web3Client(private1, httpClient);

class Web3 {
  Web3Client _client;
  Web3() {
    _client = new Web3Client(mainnet, httpClient);
  }
  static String privateKeyFromMnemonic(String mnemonic) {
    String seed = bip39.mnemonicToSeedHex(mnemonic);
    bip32.BIP32 root = bip32.BIP32.fromSeed(HEX.decode(seed));
    bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");
    String privateKey = HEX.encode(child.privateKey);
    return privateKey;
  }

  Future<String> getAddressFromPrivateKey(privateKey) async {
    try {
      // ignore: deprecated_member_use
      final credentials = await _client.credentialsFromPrivateKey(privateKey);
      return (await credentials.extractAddress()).toString();
    } catch (e) {
      return "Error in PrivateKey";
    }
  }

  Future<dynamic> sendTransactionMain(
      String address, String privateKey, EtherAmount amount, BigInt fee) async {
    try {
      Credentials credentials =
          // ignore: deprecated_member_use
          await ethClientMain.credentialsFromPrivateKey(privateKey);
      String txHash = await ethClientMain.sendTransaction(
          credentials,
          Transaction(
            to: EthereumAddress.fromHex(address),
            value: amount,
            gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, fee),
            maxGas: 21000,
          ),
          fetchChainIdFromNetworkId: true);

      var data = {'txHash': txHash, 'status': true};
      return data;
    } catch (e) {
      var data = {'status': false};
      debugPrint('e $e');
      return data;
    }
  }

  Future<dynamic> sendTransactionTest(
      String address, String privateKey, EtherAmount amount, BigInt fee) async {
    try {
      Credentials credentials =
          // ignore: deprecated_member_use
          await _client.credentialsFromPrivateKey(privateKey);
      String txHash = await _client.sendTransaction(
          credentials,
          Transaction(
            to: EthereumAddress.fromHex(address),
            value: amount,
            gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, fee),
            maxGas: 21000,
          ),
          fetchChainIdFromNetworkId: true);
      var data = {'txHash': txHash, 'status': true};
      return data;
    } catch (e) {
      var data = {'status': false};
      debugPrint('e $e');
      return data;
    }
  }
}
