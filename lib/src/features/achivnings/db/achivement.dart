import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'achivement.g.dart';

@HiveType(typeId: 1)
class Achivement {
  @HiveField(0)
  String nameOfAchivement;
  @HiveField(1)
  String id;

  Achivement({
    required this.nameOfAchivement,
    required this.id,
  });

  factory Achivement.create({required String nameOfAchivement}) {
    return Achivement(nameOfAchivement: nameOfAchivement, id: Uuid().v1());
  }
}
