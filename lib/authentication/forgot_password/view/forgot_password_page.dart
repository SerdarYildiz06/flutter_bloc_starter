import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';

import 'forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ForgotPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return ForgotPasswordBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
