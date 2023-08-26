import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/employee_model.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchAllData extends EmployeeEvent {
  const FetchAllData();

  @override
  List<Object> get props => [];
}

class FetchSpecificData extends EmployeeEvent {
  const FetchSpecificData();

  @override
  List<Object> get props => [];
}

class AddData extends EmployeeEvent {
  final EmployeeModel employee;

  const AddData({required this.employee});

  @override
  List<Object> get props => [employee];
}

class DeleteSpecificData extends EmployeeEvent {
  final EmployeeModel employee;
  BuildContext context;

   DeleteSpecificData({required this.employee,required this.context});

  @override
  List<Object> get props => [employee];
}

class UpdateSpecificData extends EmployeeEvent {
  final EmployeeModel employee;
  final String name;
  final String role;
  final DateTime joiningDate;
  final DateTime? leavingDate;

  const UpdateSpecificData(
      {required this.employee,
      required this.name,
      required this.role,
      required this.joiningDate,
      this.leavingDate});

  @override
  List<Object> get props => [name, role, joiningDate];
}
