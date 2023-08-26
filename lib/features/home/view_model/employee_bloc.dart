import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:realtime_innovations/config/resources/AppContextExtension.dart';
import 'package:realtime_innovations/features/home/view_model/employee_event.dart';
import 'package:realtime_innovations/features/home/view_model/employee_state.dart';
import 'package:realtime_innovations/utils/logger.dart';
import '../../model/employee_model.dart';
import '../repository/employee_repo.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc(this.repository) : super(const EmployeeInitial()) {


    on<FetchAllData>((event, emit) {
      try {
        emit(DisplayAllData(employees: repository.fetchAllEmployees()));
      } catch (e) {
        logger.e('$e');
      }
    });

    on<AddData>((event, emit) {
      try {
        repository.addEmployee(event.employee);
        add(const FetchAllData());
      } catch (e) {
        logger.e('$e');
      }
    });

    on<UpdateSpecificData>((event, emit) {
      try {
        repository.editEmployee(
            event.employee,
            EmployeeModel(
                name: event.name,
                role: event.role,
                joiningDate: event.joiningDate,
                leavingDate: event.leavingDate));
        add(const FetchAllData());
      } catch (e) {
        logger.e('$e');
      }
    });

    on<DeleteSpecificData>((event, emit) {
      try {
        repository.deleteEmployee(event.employee);
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          content: Text(
            'Employee data has been deleted',
            style: event.context.resources.textStyle.bodyText2
                .copyWith(color: Colors.white),
          ),
          action: SnackBarAction(
            label: 'Undo',
            textColor: const Color(0xff1DA1F2),
            onPressed: () {
              repository.addEmployee(event.employee);
              add(const FetchAllData());
            },
          ),
          duration: const Duration(seconds: 5),
        ));

        add(const FetchAllData());
      } catch (e) {
        logger.e('$e');
      }
    });
  }
}
