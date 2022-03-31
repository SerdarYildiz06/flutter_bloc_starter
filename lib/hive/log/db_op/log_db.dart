import 'package:hive/hive.dart';

import '../log.dart';

class LogDb {
  late Box hiveLogBox = Hive.box("log");

  void saveLog(Log log) {
    hiveLogBox.put("log", log);
  }
}
