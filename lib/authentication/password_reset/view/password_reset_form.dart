import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/password_reset/bloc/reset_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:flutter_bloc_login_example/util/widget/go_back.dart';


class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    Future<bool> _onWillPop() async {
      bloc.add(
        const AuthenticationStatusBackward(AuthenticationStatus.activationSuccess),
      );
      return
        false;
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<ResetBloc, ResetState>(
        listener: (context, state) {
          if (state.status == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          bloc.add(
                            const AuthenticationStatusBackward(
                                AuthenticationStatus.activationSuccess),
                          );
                        },
                        child: const GoBack(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Şifre Sıfırlama Ekranı",
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          "Geleceğe iz bırakacak bir şifre belirlemenin tam zamanı. Güçlü bir şifre seçtiğine emin ol.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(5)),
                _RePasswordInput(),
                const Padding(padding: EdgeInsets.all(10)),
                _ResetPasswordButton(),
                //_NewUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetBloc, ResetState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              key: const Key('resetPasswordForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<ResetBloc>()
                  .add(ResetPasswordPasswordChanged(password)),
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                border: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                labelText: 'Şifreniz',
                errorText: state.password.status == FormStatus.invalid
                    ? state.password.errorMessage
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RePasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetBloc, ResetState>(
      buildWhen: (previous, current) =>
      previous.repassword != current.repassword,
      builder: (context, state) {
        debugPrint("=> " + state.repassword.status.toString());
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              key: const Key('resetPasswordForm_re_passwordInput_textField'),
              onChanged: (password) => context
                  .read<ResetBloc>()
                  .add(ResetPasswordRePasswordChanged(password)),
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                border: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15)),
                labelText: 'Şifreniz Tekrar',
                errorText: state.repassword.status == FormStatus.invalid
                    ? state.repassword.errorMessage
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetBloc, ResetState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == FormStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: Colors.black,
              ),
              key: const Key('resetPasswordForm_continue_raisedButton'),
              child: const Text('Sıfırla'),
              onPressed: state.status == FormStatus.valid
                  ? () {
                context
                    .read<ResetBloc>()
                    .add(const ResetPasswordSubmitted());
              }
                  : null,
            ),
          ),
        );
      },
    );
  }
}
