import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  const User({this.id, this.name, this.surname, this.mail, this.password, this.phoneNumber, this.status, this.mode});

  final Uuid? id;
  final String? name;
  final String? surname;
  final String? mail;
  final String? password;
  final String? phoneNumber;
  final int? status;
  final int? mode;

  @override
  List<Object> get props => [User];

  //static const empty =  User(id: Uuid(), name: "Ali Çağatay", surname: "Ün", mail: "acagatayu@gmail.com", password: "123", phoneNumber: "05535977731", status: 0, mode: 0);
  static const empty =  User(id: Uuid(), name: "Ali ad", surname: "das", mail: "acadsdagatayu@gmail.com", password: "asd", phoneNumber: "sdsadas", status: 0, mode: 0);

  Map<String, dynamic> toJson(bool isLogin) => {
        "cmd": isLogin ? "Usr_Login" : "Usr_Register",
        "UMail": mail,
        "UPass": password,
        "UName": isLogin ? null : name,
        "USurname": isLogin ? null : surname,
        "UPhoneNum": phoneNumber,
        "UPhoneMdl": "IPHONE 25"
      };

  fromJsonNewLogin(Map<String, dynamic> jsonData) {
    if (jsonData["response"] == "0") {
      return "0";
    }
    return User(
      id: id,
      name: jsonData["Name"],
      surname: jsonData["SurName"],
      mail: mail,
      password: password,
      phoneNumber: jsonData["Phone_Number"],
      status: jsonData["Status"],
      mode: jsonData["Mode"],
    );
  }
}
