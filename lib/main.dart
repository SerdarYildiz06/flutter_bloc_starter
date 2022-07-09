import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_login_example/hive/log/log.dart';
import 'package:flutter_bloc_login_example/hive/user/user.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:flutter_bloc_login_example/repositories/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

/*void main() async {
  initHive().whenComplete(() => BlocOverrides.runZoned(
        () {
          runApp(App(
            authenticationRepository: AuthenticationRepository(),
            userRepository: UserRepository(),
          ));
        },
      ));
}*/
void main() async {
  initHive().whenComplete(() => BlocOverrides.runZoned(
        () {
          runApp(App(
            authenticationRepository: AuthenticationRepository(),
            userRepository: UserRepository(),
          ));
        },
        //blocObserver: MyBlocObserver(),
      ));
}

Future initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LogAdapter());

  await Hive.openBox('user');
  await Hive.openBox('log');
  await Hive.openBox('modules');
  await Hive.openBox('sensors');
  await Hive.openBox("settings");
}
