import 'package:hive/hive.dart';


part 'log.g.dart';

@HiveType(typeId: 1, adapterName: "LogAdapter")
class Log extends HiveObject {
  @HiveField(0)
  String? logType;
  @HiveField(1)
  String? blocName;
  @HiveField(2)
  String? blocRunTimeType;
  @HiveField(3)
  String? desc;

  Log(this.logType, this.blocName, this.blocRunTimeType, this.desc);




}
