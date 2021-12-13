import 'dart:convert';

import '/wallet%20api/sha3_digset.dart';
import 'package:web3dart/crypto.dart';
import "package:convert/convert.dart" show hex;

const AsciiCodec ascii = AsciiCodec();

class ValidateETH {
  bool isValidFormat(String address) {
    return RegExp(r"^[0-9a-fA-F]{40}$").hasMatch(strip0x(address));
  }

  bool isValidEthereumAddress(String address) {
    if (!isValidFormat(address)) {
      return false;
    }

    final addr = strip0x(address);
    // if all lowercase or all uppercase, as in checksum is not present
    if (RegExp(r"^[0-9a-f]{40}$").hasMatch(addr) ||
        RegExp(r"^[0-9A-F]{40}$").hasMatch(addr)) {
      return true;
    }

    String checksumAddress;
    try {
      checksumAddress = checksumEthereumAddress(address);
    } catch (err) {
      return false;
    }

    return addr == checksumAddress.substring(2);
  }

  String checksumEthereumAddress(String address) {
    if (!isValidFormat(address)) {
      throw ArgumentError.value(address, "address", "invalid address");
    }

    final addr = strip0x(address).toLowerCase();
    final hash = ascii.encode(hex.encode(
      SHA3Digest(256, true).process(ascii.encode(addr)),
    ));

    var newAddr = "0x";

    for (var i = 0; i < addr.length; i++) {
      if (hash[i] >= 56) {
        newAddr += addr[i].toUpperCase();
      } else {
        newAddr += addr[i];
      }
    }

    return newAddr;
  }
}
