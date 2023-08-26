import '../../model/employ_sort_model.dart';
import '../../model/employee_model.dart';

abstract class EmployeeRepository {

  Future<void> addEmployee(EmployeeModel employee);
  Future<void> editEmployee(EmployeeModel employee,EmployeeModel updatedDate);
  Future<void> deleteEmployee(EmployeeModel employee,);
  EmployShortedList shortEmployees(List<EmployeeModel>? unsortedEmployeeList);
  EmployShortedList fetchAllEmployees();
}