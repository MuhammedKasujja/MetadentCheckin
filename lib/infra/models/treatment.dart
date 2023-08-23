class Treatment {
  Treatment({
    required this.id,
    required this.title,
    required this.code,
    required this.color,
  });

  int id;
  String title;
  String code;
  String color;
  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "color": color,
      };
}

class Procedure {
  Procedure({
    required this.id,
    required this.code,
    required this.price,
    required this.duration,
    required this.timeUnit,
    required this.treatment,
    required this.subcategory,
    required this.waitingTime,
    required this.durationUnit,
  });

  int id;
  String code;
  String price;
  int duration;
  String timeUnit;
  String treatment;
  int subcategory;
  int waitingTime;
  String durationUnit;

  factory Procedure.fromJson(Map<String, dynamic> json) => Procedure(
        id: json["id"],
        code: json["code"],
        price: json["price"],
        duration: json["duration"],
        timeUnit: json["time_unit"],
        treatment: json["treatment"],
        subcategory: json["subcategory"],
        waitingTime: json["waiting_time"],
        durationUnit: json["duration_unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "price": price,
        "duration": duration,
        "time_unit": timeUnit,
        "treatment": treatment,
        "subcategory": subcategory,
        "waiting_time": waitingTime,
        "duration_unit": durationUnit,
      };
}
