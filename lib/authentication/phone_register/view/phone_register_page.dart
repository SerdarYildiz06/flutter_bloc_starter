import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/phone_register/bloc/phone_register_bloc.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';

import 'phone_register_form.dart';

class PhoneRegisterPage extends StatelessWidget {
  const PhoneRegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PhoneRegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Register')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return PhoneRegisterBloc(
              authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: PhoneRegisterForm(),
        ),
      ),
    );
  }
}