
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/repository/employee_repo.dart';
import '../../features/home/repository/employee_repo_impl.dart';
import '../data/local_db/hive/hive_setup.dart';
import '../data/remote/network/BaseApiService.dart';
import '../data/remote/network/NetworkApiService.dart';
import '../routers/routers.dart';

final serviceLocator = GetIt.instance;

Future<void> setUp() async {

  await HiveSetup().initializeHive();
  serviceLocator.registerLazySingleton<GoRouter>(() => router);
  serviceLocator.registerLazySingleton<BaseApiService>(() => NetworkApiService());
  serviceLocator.registerLazySingleton<EmployeeRepository>(() => EmployeeRepositoryImpl());


}