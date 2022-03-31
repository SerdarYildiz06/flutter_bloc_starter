import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/otp_verification/bloc/otp_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/otp_verification/models/otp_code.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:flutter_bloc_login_example/util/widget/go_back.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTPVerificationForm extends StatelessWidget {
  const OTPVerificationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    Future<bool> _onWillPop() async {
      bloc.add(
        const AuthenticationStatusBackward(AuthenticationStatus.activationWaitingCodeFromUser),
      );
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<OtpBloc, OtpState>(
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
          alignment: const Alignment(0, -1 / 5),
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
                            const AuthenticationStatusBackward(AuthenticationStatus.activationWaitingCodeFromUser),
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
                        "OTP Doğrulama",
                        style: TextStyle(fontSize: 30, letterSpacing: 1, fontWeight: FontWeight.bold),
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
                          "Şimdi size gönderdiğimiz SMS içerisindeki doğrulama kodunu"
                          "girmenizi bekliyoruz.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const _PINInputs(),
                const Padding(padding: EdgeInsets.all(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          debugPrint("Al sana constant value");
                        },
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                            color: Color(0xFF91D3B3),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                // _HavingAccountTextButton(),

                //_NewUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PINInputs extends StatefulWidget {
  const _PINInputs({Key? key}) : super(key: key);

  @override
  _PINInputsState createState() => _PINInputsState();
}

class _PINInputsState extends State<_PINInputs> {
  // ..text = "123456";
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    backgroundColor: Colors.white,
                    pastedTextStyle: const TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '•',
                    blinkWhenObscuring: true,

                    animationType: AnimationType.fade,
                    validator: (v) {
                      return state.otpCode.errorMessage;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      disabledColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.green.shade100,
                    ),
                    cursorColor: Colors.green,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                        context.read<OtpBloc>().add(OTPCodeChanged(value));
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
            ),
            state.status == FormStatus.valid && textEditingController.text.length < 6 ? _buildChild(state.otpCode) : Text("")
          ],
        );
      },
    );
  }

  Widget _buildChild(OTPCode state) {
    switch (textEditingController.text.length) {
      case 1:
        return const Text(
          "İlk Adım Tamam, devam.",
          style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w400),
        );
      case 2:
        return const Text("Çok iyi gidiyorsun.");

      case 3:
        return const Text("Biraz hızlanalım.");
      case 4:
        return const Text("Son iki adım.");
      case 5:
        return const Text("İşte bu, bitmek üzere.");
    }
    return const Text("");
  }
}

class _OTPSendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
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
                    key: const Key('otpForm_continue_raisedButton'),
                    child: const Text('Kayıt Ol'),
                    onPressed: state.status == FormStatus.valid
                        ? () {
                            context.read<OtpBloc>().add(const OTPSubmitted());
                          }
                        : null,
                  ),
                ),
              );
      },
    );
  }
}

class _ReSendTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
            key: const Key('otpForm_newUser_raisedButton'),
            child: const Text(
              'Giriş Yap',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              context.read<OtpBloc>().add(const OTPReSendSubmitted());
            });
      },
    );
  }
}
