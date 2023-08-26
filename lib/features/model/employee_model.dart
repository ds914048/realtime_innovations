
import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends HiveObject{

  @HiveField(0)
  String name;
  @HiveField(1)
  String role;
  @HiveField(2)
  DateTime joiningDate;
  @HiveField(3)
  DateTime? leavingDate;

  EmployeeModel({required this.name, required this.role, required this.joiningDate, this.leavingDate});

}