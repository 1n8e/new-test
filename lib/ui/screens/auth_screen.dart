import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_test/bloc/auth/auth_bloc.dart';
import 'package:new_test/consts/colors.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/ui/screens/main_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ConstColors.constBackgroundColor,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => MainScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is NotAuthState) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: CupertinoColors.white,
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Войти',
                      style: ConstTextStyles.constTitleAppBar,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: CupertinoColors.white),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Center(
                          child: CupertinoTextField(
                            controller: emailController,
                            style: TextStyle(color: Color(0xff172853)),
                            decoration:
                                BoxDecoration(color: CupertinoColors.white),
                            placeholder: 'Логин',
                            placeholderStyle:
                                ConstTextStyles.constFieldHintStyle,
                          ),
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1.5,
                      ),
                      Container(
                        height: 50,
                        child: Center(
                          child: CupertinoTextField(
                            controller: passwordController,
                            style: TextStyle(color: Color(0xff172853)),
                            obscureText: true,
                            decoration:
                                BoxDecoration(color: CupertinoColors.white),
                            placeholder: 'Пароль',
                            placeholderStyle:
                                ConstTextStyles.constFieldHintStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: double.maxFinite,
                  margin: ConstPaddings.constScreenPadding,
                  decoration: BoxDecoration(
                      color: ConstColors.constFlatButtonColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: CupertinoButton(
                    child: Text(
                      'Войти',
                      style: ConstTextStyles.constFlatButtonTitle,
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty &
                          passwordController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(
                              LoginEvent(emailController.text,
                                  passwordController.text),
                            );
                        emailController.clear();
                        passwordController.clear();
                      } else if (emailController.text.isEmpty &
                          passwordController.text.isEmpty) {
                        return 'Введите данные';
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (state is AuthFailureState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Offstage();
          }
        },
      ),
    );
  }
}
