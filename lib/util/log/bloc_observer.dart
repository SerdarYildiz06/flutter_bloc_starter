import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_login_example/hive/log/db_op/log_db.dart';
import 'package:flutter_bloc_login_example/hive/log/log.dart';

class MyBlocObserver extends BlocObserver
{
  LogDb logDb = LogDb();
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Log log = Log('onCreate --',bloc.toString(),bloc.runtimeType.toString(),bloc.runtimeType.toString());
    logDb.saveLog(log);  print(log.blocName);

  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Log log = Log('onEvent -- ',bloc.toString(),bloc.runtimeType.toString(),event.toString());
    logDb.saveLog(log);  print(log.desc);

  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Log log = Log('onChange -- ',bloc.toString(),bloc.runtimeType.toString(),change.toString());
    logDb.saveLog(log);  print(log.desc);

  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Log log = Log('onTransition -- ',bloc.toString(),bloc.runtimeType.toString(),transition.toString());
    logDb.saveLog(log);
    print(log.blocName);

  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    Log log = Log('onError -- ',bloc.toString(),bloc.runtimeType.toString(),error.toString());
    logDb.saveLog(log);
  print(log);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    Log log = Log('onError -- ',bloc.toString(),bloc.runtimeType.toString(),'');
    logDb.saveLog(log);
    print("SavedSuccessfully");
  }
}