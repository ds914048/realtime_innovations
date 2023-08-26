import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations/config/resources/AppContextExtension.dart';
import 'package:realtime_innovations/features/home/view_model/employee_bloc.dart';
import 'package:realtime_innovations/features/home/view_model/employee_state.dart';

import '../../../config/serviceLocator/serviceLocatorRegistory.dart';
import '../../../generated/assets.dart';
import '../../custom_widgets/employee_tile.dart';
import '../view_model/employee_event.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var resources = context.resources;
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: resources.textStyle.heading1,
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
        if (state is EmployeeInitial) {
          context.read<EmployeeBloc>().add(const FetchAllData());
        }
        if (state is DisplayAllData) {
          if (state.employees.currentEmployees.isNotEmpty ||
              state.employees.previousEmployees.isNotEmpty) {
            //employee list
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state.employees.currentEmployees.isNotEmpty)
                    Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Current employees',
                        style: context.resources.textStyle.heading2
                            .copyWith(color: context.resources.color.colorBlue),
                      ),
                    ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.employees.currentEmployees.length,
                      itemBuilder: (context, index) => employeeListTile(
                          context: context,
                          data: state.employees.currentEmployees[index])),
                  if (state.employees.previousEmployees.isNotEmpty)
                    Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Previous employees',
                        style: resources.textStyle.heading2
                            .copyWith(color: resources.color.colorBlue),
                      ),
                    ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.employees.previousEmployees.length,
                      itemBuilder: (context, index) => employeeListTile(
                          context: context,
                          data: state.employees.previousEmployees[index])),
                ],
              ),
            );
          } else {
            //no employee image
            return Center(
              child: Image.asset(
                Assets.imagesNoEmployee,
                width: context.width * 0.65,
              ),
            );
          }
        }
        return const CircularProgressIndicator();
      }),
      bottomNavigationBar:
          BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
        if (state is DisplayAllData) {
          if (state.employees.currentEmployees.isNotEmpty ||
              state.employees.previousEmployees.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 15, top: 10),
              child: Text(
                'Swipe left to delete',
                style: resources.textStyle.bodyText2
                    .copyWith(color: resources.color.colorGray),
              ),
            );
          }
        }
        return const SizedBox();
      }),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: resources.color.colorBlue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Icon(Icons.add, color: resources.color.colorWhite),
            onPressed: () {
              serviceLocator<GoRouter>().push(
                '/add_employee',
              );
            },
          ),
        ),
      ),
    );
  }
}
