import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../bloc/home_bloc.dart';
import '../page_bloc/page_bloc.dart';
import 'home_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
            providers: [

          BlocProvider(
            create: (context) {
              return PageBloc();
            },
          ),

        ],
            child: MaterialApp(

                home: const HomeForm())));
  }
}
