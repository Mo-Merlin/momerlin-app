import 'dart:ui';

class SpendingReports {
  String displayName;
  String category;
  String image;
  var color;
  int transactionsCount;
  var percentage;
  var amount;
  SpendingReports({
    this.displayName,
    this.category,
    this.image,
    this.color,
    this.transactionsCount,
    this.percentage,
    this.amount,
  });

  factory SpendingReports.fromJson(Map<String, dynamic> json) =>
      SpendingReports(
        displayName: json["displayName"],
        category: json["category"],
        image: json["image"],
        color: json["color"],
        transactionsCount: json["transactionsCount"],
        percentage: json["percentage"],
        amount: json["amount"],
      );
}
