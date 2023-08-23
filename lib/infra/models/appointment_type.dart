class AppointmentType {
  AppointmentType({
    required this.id,
    required this.title,
    required this.code,
    required this.color,
    required this.agendaInterval,
  });

  int id;
  String title;
  String code;
  String color;
  int agendaInterval;

  factory AppointmentType.fromJson(Map<String, dynamic> json) =>
      AppointmentType(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        color: json["color"],
        agendaInterval: json["agenda_interval"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "color": color,
        'agenda_interval': agendaInterval,
      };
}
