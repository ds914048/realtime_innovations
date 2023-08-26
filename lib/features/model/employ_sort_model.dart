import 'employee_model.dart';

class EmployShortedList{
  List<EmployeeModel> previousEmployees ;
  List<EmployeeModel> currentEmployees;
  EmployShortedList(this.currentEmployees,this.previousEmployees);
}