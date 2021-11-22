class MyEarningActivity {
    MyEarningActivity({
        this.title,
        this.date,
        this.image,
        this.color,
        this.amount,
    });

    String title;
    DateTime date;
    String image;
    String color;
    String amount;

    factory MyEarningActivity.fromJson(Map<String, dynamic> json) => MyEarningActivity(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        image: json["image"],
        color: json["color"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "date": date.toIso8601String(),
        "image": image,
        "color": color,
        "amount": amount,
    };
}