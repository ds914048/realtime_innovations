import 'package:flutter/cupertino.dart';

import 'Resources.dart';
extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
  double get width =>MediaQuery.of(this).size.width;
  double get height =>MediaQuery.of(this).size.height;

}