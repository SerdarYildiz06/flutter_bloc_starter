import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(child: Text('Uygulamadan Çıkış')),
              content: const Text('Uygulamadan çıkmak mı istiyorsunuz?'),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Evet'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Hayır'),
                    ),
                  ],
                )
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Server ile bağlantı kuramadık.')),
              );
          }

          else if (state.status == FormStatus.wrongAuthentication) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Hatalı kullanıcı adı veya şifre.')),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Giriş Ekranı",
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
                          "Sizin siz olduğunuzdan emin olmak istiyoruz.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(15)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(5)),
                _LoginButton(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _ForgotPasswordTextButton(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        )),
                        Text("ve ya"),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Hesabınız yok mu?"),
                          const SizedBox(
                            width: 14,
                          ),
                          _NewUserTextButton(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
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
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Kullanıcı Adı',
                  errorText: state.username.status == FormStatus.invalid
                      ? state.username.errorMessage
                      : null),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
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
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Şifreniz',
                  errorText: state.password.status == FormStatus.invalid
                      ? state.password.errorMessage
                      : null),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
                    key: const Key('loginForm_continue_raisedButton'),
                    child: const Text('Giriş Yap'),
                    onPressed: state.status == FormStatus.valid
                    || state.status == FormStatus.submissionSuccess
                        ? () {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
                        : null,
                  ),
                ),
              );
      },
    );
  }
}

class _ForgotPasswordTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        key: const Key('loginForm_forgotPassword_raisedButton'),
        child: const Text(
          'Şifrenizi mi unuttunuz ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
        onPressed: () {
          context.read<LoginBloc>().add(
              const ForgotPasswordRequestSubmitted(AuthenticationStatus.login));
        });
  }
}

class _NewUserTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        key: const Key('loginForm_newUser_raisedButton'),
        child: const Text(
          'Kayıt Ol',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
        onPressed: () {
          context.read<LoginBloc>().add(const RegisterRequestFromLoginSubmitted(
              AuthenticationStatus.login));
        });
  }
}
