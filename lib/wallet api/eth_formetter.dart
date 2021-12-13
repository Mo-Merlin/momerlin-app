import 'package:web3dart/web3dart.dart';

class EthAmountFormatter {
  EthAmountFormatter(this.amount);

  final BigInt amount;
  String format({
    fromUnit = EtherUnit.wei,
    toUnit = EtherUnit.ether,
  }) {
    if (amount == null) return "-";
    var value =
        EtherAmount.fromUnitAndValue(fromUnit, amount).getValueInUnit(toUnit);
    var intvalue = (value * 10000).floor().toString();
    var finalvalue = (double.parse(intvalue) / 10000).toStringAsFixed(3);
    return finalvalue;
  }
}
