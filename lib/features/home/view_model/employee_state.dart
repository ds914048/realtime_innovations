// part of 'Employee_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:realtime_innovations/features/model/employ_sort_model.dart';

import '../../model/employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {
  const EmployeeInitial();

  @override
  List<Object> get props => [];
}

class DisplayAllData extends EmployeeState {
  final EmployShortedList employees;

  const DisplayAllData({required this.employees});

  @override
  List<Object> get props => [employees];
}

class DisplaySpecificData extends EmployeeState {
  final EmployeeModel employee;

  const DisplaySpecificData({required this.employee});

  @override
  List<Object> get props => [employee];
}
