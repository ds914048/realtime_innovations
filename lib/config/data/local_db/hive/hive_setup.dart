import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realtime_innovations/utils/logger.dart';

import '../../../../features/model/employee_model.dart';

class HiveSetup{

  Future<void> initializeHive()async{
    var directory=await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(EmployeeModelAdapter());
    await Hive.openBox<EmployeeModel>('employees');

  }


  Future<void> putDataInHive({required String boxId,required dynamic key,required dynamic value})async{
    var box = await Hive.openBox(boxId);
    box.put(key,value).
    catchError((error)=>logger.e(error)).
    whenComplete(() =>  logger.i('data added successfully in $boxId KEY : $key \nVALUE : $value'));
  }


  // {'name':'asd',
  // 'role':'',
  // 'DateFrom':DateTime.now(),
  // 'DateTo':DateTime.now()
  // }
}