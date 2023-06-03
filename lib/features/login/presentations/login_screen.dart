import 'package:alpha/core/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/locale_keys.g.dart';
import '../applications/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailState) {
              print('LoginFailState');
            }
            if (state is LoginSuccessState) {
              print('LoginSuccessState');
            }
          },
          child: _BodyScreen(),
        ),
      ),
    );
  }
}

class _BodyScreen extends StatelessWidget {
  const _BodyScreen();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tr(LocaleKeys.common_welcomeTitle),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          InkWell(
            onTap: () async {
              BlocProvider.of<LoginBloc>(context).add(
                LoginWithGmailEvent(),
              );
            },
            child: const Icon(
              Icons.mail_outlined,
              color: Colors.blueGrey,
              size: Constants.iconSizeLarge,
            ),
          ),
        ],
      ),
    );
  }
}
