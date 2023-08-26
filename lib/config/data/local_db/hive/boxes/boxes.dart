
import 'package:hive/hive.dart';

import '../../../../../features/model/employee_model.dart';

class Boxes{

  static Box<EmployeeModel> getData()=>Hive.box<EmployeeModel>('employees');
}