import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/register/view/register_page.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:flutter_bloc_login_example/repositories/user_repository.dart';
import 'package:flutter_bloc_login_example/splash/splash.dart';
import 'package:hive_listener/hive_listener.dart';

import 'package:hive/hive.dart';

import 'auth/bloc/auth_bloc.dart';
import 'authentication/forgot_password/view/forgot_password_page.dart';
import 'authentication/helper/curve_painter.dart';
import 'authentication/login/view/login_page.dart';
import 'authentication/otp_verification/view/otp_verification_page.dart';
import 'home/main_home/view/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return HiveListener(
      box: Hive.box("settings"),
      keys: const ["language"],
      builder: (context) => MaterialApp(

        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return RepositoryProvider.value(
            value: UserRepository(),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (_, state) {
                debugPrint("Status has been changed.");
                switch (state.status) {

                 case AuthenticationStatus.authenticated:
                    isAuthenticated = true;
                    _navigator.pushAndRemoveUntil<void>(
                      HomePage.route(),
                          (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    isAuthenticated = true;

                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                          (route) => false,
                    );
                    break;

                  case AuthenticationStatus.login:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                          (route) => false,
                    );
                    break;
                  case AuthenticationStatus.activationNone:
                    _navigator.pushAndRemoveUntil<void>(
                      ForgotPasswordPage.route(),
                          (route) => false,
                    );
                    break;
                 case AuthenticationStatus.signUp:
                    _navigator.pushAndRemoveUntil<void>(
                      RegisterPage.route(),
                          (route) => false,
                    );
                    break;
                  case AuthenticationStatus.activationWaitingCodeFromUser:
                    _navigator.pushAndRemoveUntil<void>(
                      OTPVerificationPage.route(),
                          (route) => false,
                    );
                    break;

                }
              },
              builder: (BuildContext context, state) {
                if (!isAuthenticated) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0.0,
                          right: 0.0,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: child,
                            ),
                          ),
                        ),
                        IgnorePointer(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: CustomPaint(
                                size: Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.width * 0.1586908077994429).toDouble()),
                                painter: CurvePainter(),
                              ),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomPaint(
                              size: Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.width * 0.2086908077994429).toDouble()),
                              painter: CurvePainter(),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(child: child);
                }
              },
            ),
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}
