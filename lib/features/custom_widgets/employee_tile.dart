import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations/config/resources/AppContextExtension.dart';
import 'package:realtime_innovations/utils/extension/date_extension.dart';

import '../../config/data/local_db/hive/boxes/boxes.dart';
import '../../config/serviceLocator/serviceLocatorRegistory.dart';
import '../../generated/assets.dart';
import '../home/repository/employee_repo.dart';
import '../home/view_model/employee_bloc.dart';
import '../home/view_model/employee_event.dart';
import '../home/view_model/employee_state.dart';
import '../model/employee_model.dart';
Widget employeeListTile(
    {required BuildContext context, required EmployeeModel data}) =>
    GestureDetector(
      onTap: (){
        serviceLocator<GoRouter>().push(
          '/edit_employee',
          extra: data,
        );
        },
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          extentRatio: 0.17,
          motion: const ScrollMotion(),
          children: [
            BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state)=> GestureDetector(
                onTap: () {
                  context.read<EmployeeBloc>().add(DeleteSpecificData(employee: data, context: context));
                  final slidableState = Slidable.of(context);
                  slidableState?.dismiss(ResizeRequest(
                    Duration.zero,
                        () {},
                  ));
                },
                child: Container(
                  height: 100,
                  width: context.width * 0.17,
                  color: Colors.red,
                  child: Center(
                      child: Image.asset(
                        Assets.iconsDelete,
                        height: 18,
                      )),
                ),
              ),
            )
          ],
        ),
        child: Container(
          height: 104,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xffF2F2F2),
                // width: borderWidth,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                data.name,
                style: context.resources.textStyle.heading2,
              ),
              Text(
                data.role,
                style: context.resources.textStyle.subHeading1
                    .copyWith(color: const Color(0xff949C9E)),
              ),
              data.leavingDate == null
                  ? Text(
                'From ${data.joiningDate.formatDate(withComma: true)}',
                style: context.resources.textStyle.bodyText4,
              )
                  : Text(
                '${data.joiningDate.formatDate(shortName: true)} - ${data.leavingDate?.formatDate(withComma: true)}',
                style: context.resources.textStyle.bodyText4,
              ),
            ],
          ),
        ),
      ),
    );
