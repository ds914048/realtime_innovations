
import 'package:go_router/go_router.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:realtime_innovations/features/home/view/home.dart';
import 'package:realtime_innovations/features/home/view/add_employee.dart';
import 'package:realtime_innovations/features/home/view/edit_employee.dart';
import 'package:realtime_innovations/features/model/employee_model.dart';



final router = GoRouter(
  initialLocation: '/',
  observers: [
    NavigationHistoryObserver(),
  ],
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/add_employee',
      name: 'AddEmployee',
      builder: (context, state) =>  const AddEmployee(),
    ),
    GoRoute(
      path: '/edit_employee',
      name: 'EditEmployee',
      builder: (context, state) =>   EditEmployee(employeeModel: state.extra as EmployeeModel),
    ),
    //
    //
    // GoRoute(
    //   path: DeepLinkTrackingScreen.routeName,
    //   name: 'DeepLinkTrackingScreen',
    //   builder: (context, state) => DeepLinkTrackingScreen(
    //     refferalId: state.queryParams['refId']?.toString(),
    //   ),
    // ),
    //
    // GoRoute(
    //   path: '/error_screen',
    //   name: 'ErrorScreen',
    //   builder: (context, state) => ErrorScreen(
    //     errorTitle: state.extra?.toString(),
    //   ),
    // ),
    // GoRoute(
    //   path: '/thanks_screen',
    //   name: 'ThankYouScreen',
    //   builder: (context, state) => ThankYouScreen(
    //     errorTitle: state.extra?.toString(),
    //   ),
    // ),


  ],
  // errorBuilder: (context, state) => RedirectOnErrorScreen(routerState: state),
);
