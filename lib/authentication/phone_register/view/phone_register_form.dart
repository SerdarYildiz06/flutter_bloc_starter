import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/phone_register/bloc/phone_register_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';

class PhoneRegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneRegisterBloc, PhoneRegisterState>(
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
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PhoneNumberInput(),
            const Padding(padding: EdgeInsets.all(12)),

            _PhoneVerifyButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _PhoneNumberUncorrectInfoTextButton(),
            const Padding(padding: EdgeInsets.all(12)),
            //_NewUser(),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneRegisterBloc, PhoneRegisterState>(
      //buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('phoneRegisterForm_usernameInput_textField'),
          onChanged: (phoneNumber) => context.read<PhoneRegisterBloc>().add(PhoneRegisterPhoneNumberChanged(phoneNumber)),
          decoration: const InputDecoration(
            labelText: 'phoneNumber',
            //errorText: state.phoneNumber.invalid ? 'invalid phoneNumber' : null,
          ),
        );
      },
    );
  }
}

class _PhoneVerifyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneRegisterBloc, PhoneRegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == FormStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('phoneRegisterForm_verify_raisedButton'),
          child: const Text('Verify'),
          onPressed: state.status == FormStatus.valid
              || state.status == FormStatus.submissionSuccess
              ? () {
            context.read<PhoneRegisterBloc>().add(const PhoneRegisterPhoneNumberSubmitted());
          }
              : null,
        );
      },
    );
  }
}

class _PhoneNumberUncorrectInfoTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneRegisterBloc, PhoneRegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
            key: const Key('loginForm_forgotPassword_raisedButton'),
            child: const Text('I have a mistake, take me back'),
            onPressed: () {
             /* Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );*/
            });
      },
    );
  }
}
