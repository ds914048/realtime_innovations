
import 'package:realtime_innovations/features/model/employ_sort_model.dart';

import '../../../config/data/local_db/hive/boxes/boxes.dart';
import '../../model/employee_model.dart';
import 'employee_repo.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final employeeBox = Boxes.getData();

  @override
  Future<void> addEmployee(EmployeeModel employee) async {
    await employeeBox.add(employee);

  }

  @override
  Future<void> deleteEmployee(EmployeeModel employee) async {
    await employee.delete();
  }

  @override
  EmployShortedList shortEmployees(List<EmployeeModel>? unsortedEmployeeList) {
    List<EmployeeModel> previousEmployees = [];
    List<EmployeeModel> currentEmployees = [];

    if(unsortedEmployeeList!=null){
      for (EmployeeModel employee in unsortedEmployeeList) {
        if (employee.leavingDate == null ||
            employee.leavingDate!.isAfter(DateTime.now())) {
          currentEmployees.add(employee);
        } else {
          previousEmployees.add(employee);
        }
      }
      previousEmployees.sort((a, b) => b.joiningDate.compareTo(a.joiningDate));
      currentEmployees.sort((a, b) => b.joiningDate.compareTo(a.joiningDate));
    }
     return EmployShortedList(currentEmployees, previousEmployees);

  }

  @override
  Future<void> editEmployee(EmployeeModel employee, EmployeeModel updatedDate) async {

    employee.name=updatedDate.name;
    employee.role=updatedDate.role;
    employee.joiningDate=updatedDate.joiningDate;
    employee.leavingDate=updatedDate.leavingDate;
    employee.save();
  }

  @override
  EmployShortedList fetchAllEmployees() {
    try {
      List<EmployeeModel> employees = [];
      employees = employeeBox.values.toList();
      EmployShortedList sortedList = shortEmployees(employees);
      return sortedList;
    } catch (e) {
      print('$e');
    }
    return EmployShortedList([],[]);
  }


}