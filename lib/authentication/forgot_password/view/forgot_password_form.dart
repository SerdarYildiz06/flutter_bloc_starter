import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:flutter_bloc_login_example/util/widget/go_back.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    Future<bool> _onWillPop() async {
      bloc.add(
        const AuthenticationStatusBackward(AuthenticationStatus.activationNone),
      );
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          /*if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }*/
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
                            const AuthenticationStatusBackward(AuthenticationStatus.activationNone),
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
                        "Şifremi Unuttum",
                        style: TextStyle(fontSize: 30, letterSpacing: 1, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 15),
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          "Telefonunuza bir aktivasyon kodu gönderebilmemiz için, lütfen telefonunuzu giriniz.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                _PhoneNumberInput(),
                const Padding(padding: EdgeInsets.all(15)),
                _PasswordResetButton(),
                const Padding(padding: EdgeInsets.all(15)),
                // _HavingAccountTextButton(),
                Column(
                  children: [
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
                      padding: const EdgeInsets.all(15.0),
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
                //_NewUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  var textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'TR';
  PhoneNumber numberLo = PhoneNumber(isoCode: 'TR');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 120,
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                debugPrint("OnInputValidated");

                numberLo = number;
              },
              onInputValidated: (bool value) {
                debugPrint("OnInputValidated");
                context.read<ForgotPasswordBloc>().add(ForgotPasswordPhoneNumberChanged(numberLo.phoneNumber!, value));
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.always,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: numberLo,
              textFieldController: controller,
              formatInput: false,

              //keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}

/*
class _PhoneNumberInput_Old extends StatelessWidget {
  var textEditingController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(mask: '+90 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          controller: textEditingController,
          inputFormatters: [maskFormatter],
          key: const Key('forgotPasswordForm_phoneNumberInput_textField'),
          onChanged: (phoneNumber) => context.read<ForgotPasswordBloc>().add(ForgotPasswordPhoneNumberChanged(textEditingController.text)),
          decoration: InputDecoration(
            labelText: 'Phone Number',
            errorText: state.phoneNumber.invalid ? 'invalid phone number' : null,
          ),
        );
      },
    );
  }
}
*/
class _PasswordResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
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
                      key: const Key('forgotPasswordForm_reset_raisedButton'),
                      child: const Text('Kod Gönder'),
                      //TODO: Get rid of from Formz
                      onPressed: state.status.isValidated
                          ? () {
                              context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitted());
                            }
                          : null),
                ),
              );
      },
    );
  }
}

class _NewUserTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
            key: const Key('forgotPasswordForm_newUser_raisedButton'),
            child: const Text(
              'Kayıt Ol',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              context.read<ForgotPasswordBloc>().add(const RegisterRequestSubmitted(AuthenticationStatus.activationFail));
            });
      },
    );
  }
}
