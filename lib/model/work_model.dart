import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
 part 'work_model.g.dart';
@HiveType(typeId: 1)
class WorkModel{
  @HiveField(0)
  String? work;
  @HiveField(1)
  String? date;
  WorkModel(
    {
      this.work,
      this.date
    }
  );

}