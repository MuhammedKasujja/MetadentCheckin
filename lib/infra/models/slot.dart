import 'package:equatable/equatable.dart';

class Slot extends Equatable {
  final String startTime;
  final String endTime;
  final int? id;

  const Slot({
    required this.startTime,
    required this.endTime,
    this.id,
  });

  @override
  List<Object?> get props => [startTime, endTime];

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'],
      startTime: json['start-time'] ?? json['start_time'],
      endTime: json['end-time'] ?? json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start-time': startTime,
      'end-time': endTime,
    };
  }
}
