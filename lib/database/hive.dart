import 'package:hive/hive.dart';
part 'hive.g.dart';
@HiveType(typeId: 0)
class StudentDetail extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String domain;
  @HiveField(4)
  final String imagePath;

StudentDetail({required this.name,required this.age,required this.place,required this.domain,required this.imagePath});
  
}
