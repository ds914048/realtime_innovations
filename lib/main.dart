import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import '../config/resources/AppContextExtension.dart';
import '../utils/services/alert_service/alert_service.dart';
import 'config/serviceLocator/serviceLocatorRegistory.dart';
import 'features/home/repository/employee_repo.dart';
import 'features/home/view_model/employee_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = serviceLocator<GoRouter>();

    return MultiProvider(
      providers: [
        BlocProvider(
        create: (context) => EmployeeBloc(serviceLocator<EmployeeRepository>()),),
      ],
      child: OverlaySupport.global(
        child:  MaterialApp.router(
          scaffoldMessengerKey: globalSnackbarKey,
          debugShowCheckedModeBanner: false,

          builder: (context, myWidget) {
            myWidget = EasyLoading.init()(context, myWidget);
            return MediaQuery(
              child: myWidget,
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                highContrast: false,
              ),
            );
            // return myWidget;
          },

          routerDelegate: appRouter.routerDelegate,
          routeInformationProvider: appRouter.routeInformationProvider,
          routeInformationParser: appRouter.routeInformationParser,
        ),
      ),
    );
  }
}