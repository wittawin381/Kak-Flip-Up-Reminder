class Alarm {
  final int id;
  final String dateTime;
  final int autoalarm;
  final int alarmcount;
  Alarm({this.id, this.dateTime, this.autoalarm, this.alarmcount});

  @override
  String toString() {
    // TODO: implement toString
    return "Alarm{id: $id, date: $dateTime}";
  }
}
