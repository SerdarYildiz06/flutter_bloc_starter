import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@HiveType(typeId: 0, adapterName: "UserAdapter")
class User extends HiveObject {
  @HiveField(0)
  Uuid? uuid;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? surName;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? mail;
  @HiveField(5)
  String? password;
  @HiveField(6)
  int? status;
  @HiveField(7)
  int? mode;

  User({this.uuid,this.name, this.mail, this.password, this.surName, this.phoneNumber, this.status, this.mode});



}
