class Transaction {
  var amount;
  var sats;
  DateTime date;
  String merchantName;
  var iso_currency_code;
  Transaction({
    this.amount,
    this.date,
    this.merchantName,
    this.sats,
    this.iso_currency_code,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        date: DateTime.parse(json["time"]),
        sats: json["sats"],
        iso_currency_code: json['iso_currency_code'],
        merchantName:
            json["merchant_name"] == null ? null : json["merchant_name"],
      );
}