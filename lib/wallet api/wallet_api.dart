import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart' as http;

// const etherem = "https://mainnet.infura.io/v3/21485433cdfb42388fbfe0f5da415eae";
const binance = "https://bsc-dataseed.binance.org/";
const etherem = "https://rinkeby.infura.io/v3/21485433cdfb42388fbfe0f5da415eae";
// const binance = "https://data-seed-prebsc-1-s1.binance.org:8545/";

final httpClient = new Client();
final Web3Client ethClientTest = new Web3Client(etherem, httpClient);
final Web3Client ethClientbnb = new Web3Client(binance, httpClient);

class WalletApi {
  Web3Client _client;
  WalletApi() {
    _client = new Web3Client(etherem, httpClient);
  }

  static String getSeed() {
    final seed = bip39.generateMnemonic();
    return seed;
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

  Future<EtherAmount> getBalanceEth({String address}) async {
    EthereumAddress a;
    if (address != null && address != "") {
      a = EthereumAddress.fromHex(address);
    }
    return await ethClientTest.getBalance(a);
  }

  Future<EtherAmount> getBalanceBnb({String address}) async {
    EthereumAddress a;
    if (address != null && address != "") {
      a = EthereumAddress.fromHex(address);
    }
    return await ethClientbnb.getBalance(a);
  }

  Future<dynamic> sendTransactionEth(
      String address, String privateKey, EtherAmount amount, BigInt fee) async {
    try {
      Credentials credentials =
          // ignore: deprecated_member_use
          await ethClientTest.credentialsFromPrivateKey(privateKey);
      String txHash = await ethClientTest.sendTransaction(
          credentials,
          Transaction(
            to: EthereumAddress.fromHex(address),
            value: amount,
            gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, fee),
            maxGas: 21000,
          ),
          chainId: null,
          fetchChainIdFromNetworkId: true);
      var data = {'txHash': txHash, 'status': true};
      return data;
    } catch (e) {
      var data = {'status': false};
      debugPrint('e $e');
      return data;
    }
  }

  Future<dynamic> sendTransactionBNB(
      String address, String privateKey, EtherAmount amount, BigInt fee) async {
    try {
      Credentials credentials =
          // ignore: deprecated_member_use
          await ethClientbnb.credentialsFromPrivateKey(privateKey);
      String txHash = await ethClientbnb.sendTransaction(
          credentials,
          Transaction(
            to: EthereumAddress.fromHex(address),
            value: amount,
            gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, fee),
            maxGas: 51000,
          ),
          chainId: 56,
          fetchChainIdFromNetworkId: false);

      var data = {'txHash': txHash, 'status': true};
      return data;
    } catch (e) {
      var data = {'status': false};
      debugPrint('e $e');
      return data;
    }
  }

  Future getEthTransactions(String address) async {
    var url =
        "http://api-rinkeby.etherscan.io/api?module=account&action=txlist&address=$address&startblock=0&endblock=99999999&sort=desc&apikey=9EX9NNKAYXM23UA9NNYW8K2FFWVJF73628";
    try {
      var res = await http.get(Uri.parse(url));
      String source = Utf8Decoder().convert(res.bodyBytes);
      var eth = jsonDecode(source);
      return eth;
    } catch (e) {
      print("Can't get transactions $e");
    }
  }

  Future getBnbTransactions(String address) async {
    var url =
        "http://api.bscscan.com/api?module=account&action=txlist&address=$address&startblock=0&endblock=99999999&sort=desc&apikey=8RCNB87ME6ANTUS1B7CPEHGX493W4KBRN3";
    try {
      var res = await http.get(Uri.parse(url));
      String source = Utf8Decoder().convert(res.bodyBytes);
      var bnb = jsonDecode(source);
      return bnb;
    } catch (e) {
      print("Can't get transactions $e");
    }
  }
}
