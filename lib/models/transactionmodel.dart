class Transaction {
  String address;
  String amount;
  String category;
  DateTime date;
  String isoCurrencyCode;
  String merchantName;
  String name;
  var sats;

  Transaction(
      {this.address,
      this.amount,
      this.category,
      this.date,
      this.isoCurrencyCode,
      this.merchantName,
      this.name,
      this.sats});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        address: json["address"],
        amount: json["amount"],
        category: json["category"],

        date: DateTime.fromMillisecondsSinceEpoch(num.parse(json["createdAt"])),
        isoCurrencyCode: json["iso_currency_code"],
        merchantName: json["merchant_name"],
        name: json["name"],
        sats: json["sats"],
        // date: DateTime.parse(json["time"]),
      );
}
