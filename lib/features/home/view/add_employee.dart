import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations/config/serviceLocator/serviceLocatorRegistory.dart';
import 'package:realtime_innovations/features/home/repository/employee_repo.dart';
import 'package:realtime_innovations/generated/assets.dart';
import 'package:realtime_innovations/utils/extension/date_extension.dart';
import 'package:realtime_innovations/utils/services/alert_service/alert_service.dart';
import '../../../config/resources/AppContextExtension.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_date_picker/view/custom_date_picker.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/role_bottom_sheet.dart';
import '../../model/employee_model.dart';
import '../view_model/employee_bloc.dart';
import '../view_model/employee_event.dart';
import 'package:flutter/services.dart';


class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  final name = TextEditingController();
  final role = TextEditingController();
  final joiningDate = TextEditingController();
  final leavingDate = TextEditingController();

  DateTime? joiningDateTime;
  DateTime? leavingDateTime;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1DA1F2),
        title: Text(
          'Add Employee Details',
          style: context.resources.textStyle.heading1,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customTextFormField(
                controller: name,
                prefixIcon: Icons.perm_identity,
                hintText: 'Employee name'),
            customTextFormField(
                controller: role,
                readOnly: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    builder: (BuildContext context) {
                      return const RoleSelectionBottomSheet();
                    },
                  ).then((value) {
                    if (value != null && value is String) {
                      setState(() {
                        role.text = value;
                      });
                    }
                  });
                },
                prefixIcon: Icons.work_outline,
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                    Assets.iconsArrowDropDown,
                    width: 20,
                  ),
                ),
                hintText: 'Select role'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.width * 0.4,
                  child: customTextFormField(
                      controller: joiningDate,
                      readOnly: true,
                      hintText: 'Today',
                      prefixIcon: Icons.event_outlined,
                      onTap: () async {
                        await customDatePicker(context: context).then((value) {
                          if (value != null) {
                            DateTime selectedDate = value;
                            setState(() {
                              joiningDate.text =
                                  selectedDate.formatDate(shortName: true);
                              joiningDateTime = value;
                            });
                          }else{
                            setState(() {
                              joiningDate.text = '';
                              joiningDateTime = null;
                            });
                          }
                        });
                      }),
                ),
                Image.asset(
                  Assets.iconsArrowRightAlt,
                  width: 20,
                ),
                SizedBox(
                  width: context.width * 0.4,
                  child: customTextFormField(
                      controller: leavingDate,
                      hintText: 'No Date',
                      prefixIcon: Icons.event_outlined,
                      readOnly: true,
                      onTap: () async {
                        await customDatePicker(
                                context: context, isJoiningDate: false)
                            .then((value) {
                          if (value != null) {
                            DateTime selectedDate = value;
                            setState(() {
                              leavingDate.text = selectedDate.formatDate(
                                shortName: true,
                              );
                              leavingDateTime = value;
                            });
                          }else{
                            setState(() {
                              leavingDate.text = '';
                              leavingDateTime = null;
                            });
                          }
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(thickness: 2, color: Color(0xffF2F2F2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customButton(
                width: 75,
                height: 40,
                onTap: () {
                  context.pop();
                },
                text: 'Cancel',
              ),
              const SizedBox(
                width: 10,
              ),
              customButton(
                width: 75,
                height: 40,
                highlightButton: true,
                onTap: () {
                  if (name.text.isEmpty ||
                      role.text.isEmpty ||
                      joiningDate.text.isEmpty) {
                    AlertService.show(
                      text: 'Please fill required field.',
                      type: AlertType.snackBar,
                    );
                  } else if (leavingDateTime != null &&
                      leavingDateTime!.isBefore(joiningDateTime!)) {
                    AlertService.show(
                      text: 'Leaving date can\'t be before joining date',
                      type: AlertType.snackBar,
                    );
                  } else {
                    context.read<EmployeeBloc>().add(AddData(
                        employee: EmployeeModel(
                            name: name.text,
                            role: role.text,
                            joiningDate: joiningDateTime??DateTime.now(),
                            leavingDate: leavingDateTime)));
                    context.pop();
                  }
                },
                text: 'Save',
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
