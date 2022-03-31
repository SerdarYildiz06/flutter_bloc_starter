import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/password_reset/bloc/reset_bloc.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';

import 'password_reset_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ResetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return ResetBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: ResetPasswordForm(),
        ),
      ),
    );
  }
}
