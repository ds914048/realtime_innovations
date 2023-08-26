import 'package:flutter/material.dart';
import 'package:realtime_innovations/config/resources/AppContextExtension.dart';
class RoleSelectionBottomSheet extends StatelessWidget {
  const RoleSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner'
    ];
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 50,
          child: ListTile(
            title: Center(
                child: Text(
                  roles[index],
                  style: context.resources.textStyle.bodyText3
                      .copyWith(color: Colors.black),
                )),
            onTap: () {
              // Handle role selection here
              Navigator.pop(context,roles[index]); // Close the bottom sheet
            },
          ),
        );
      },
    );
  }
}