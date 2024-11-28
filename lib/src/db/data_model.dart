import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class MyDate {
  @HiveField(0)
  String id;
  @HiveField(1)
  int days;
  @HiveField(2)
  String date;

  factory MyDate.create({
    required int days,
    required String date,
  }) {
    final id = const Uuid().v1();
    return MyDate(id: id, days: days, date: date);
  }

  MyDate({
    required this.id,
    required this.days,
    required this.date,
  });
}
