class AlarmModel {
  final String id;
  final String time;
  final String date;
  final DateTime dateTime;
  bool isActive;

  AlarmModel({
    required this.id,
    required this.time,
    required this.date,
    required this.dateTime,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'date': date,
      'dateTime': dateTime.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }

  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'],
      time: map['time'],
      date: map['date'],
      dateTime: DateTime.parse(map['dateTime']),
      isActive: map['isActive'] == 1,
    );
  }
}