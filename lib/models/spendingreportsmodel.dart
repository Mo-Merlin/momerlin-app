class SpendingReports {
  var amount;
  var sats;
  DateTime date;
  String merchantName;
  var isocurrencycode;
  var category;
  var name;
  var address;
  SpendingReports({
    this.amount,
    this.date,
    this.merchantName,
    this.sats,
    this.isocurrencycode,
    this.category,
    this.name,
    this.address,
  });

  factory SpendingReports.fromJson(Map<String, dynamic> json) =>
      SpendingReports(
          amount: json["amount"],
          date: DateTime.parse(json["time"]),
          sats: json["sats"],
          isocurrencycode: json['iso_currency_code'],
          merchantName:
              json["merchant_name"] == null ? null : json["merchant_name"],
          category: json["category"],
          name: json["name"],
          address: json["address"]);
}
