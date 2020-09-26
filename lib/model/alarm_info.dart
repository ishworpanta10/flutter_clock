class AlarmInfo {
  // commnly used variables
  static final tableName = 'myNoteTable';

  // for table column
  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnDateTime = 'alarmDateTime';
  static final columnisPending = 'isPending';
  static final columnColorIndex = 'gradientColorIndex';

  int id;
  DateTime alarmDateTime;
  String alarmTitle;
  bool isPending;
  int gradientColorIndex;

  AlarmInfo(
      {this.id,
      this.alarmDateTime,
      this.alarmTitle,
      this.isPending,
      this.gradientColorIndex});

  // reterive object from map
  factory AlarmInfo.fromMap(Map<String, dynamic> map) => AlarmInfo(
      id: map[columnId],
      alarmTitle: map[columnTitle],
      isPending: map[columnisPending],
      alarmDateTime: DateTime.parse(map[columnDateTime]),
      gradientColorIndex: map[columnColorIndex]);

// storeing map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[columnId] = id;
    }
    map[columnTitle] = alarmTitle;
    map[columnDateTime] = alarmDateTime.toIso8601String();
    map[columnisPending] = isPending;
    map[columnColorIndex] = gradientColorIndex;

    return map;
  }
}
