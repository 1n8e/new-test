import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_test/bloc/auth/auth_bloc.dart';
import 'package:new_test/consts/colors.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/ui/screens/auth_screen.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _switchController = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: ConstColors.constBackgroundColor,
          child: Column(
            children: [
              Container(
                child: Align(
                  child: Text(
                    'Имя',
                    style: ConstTextStyles.constTitleAppBar,
                  ),
                  alignment: Alignment.center,
                ),
                height: 55,
                decoration: BoxDecoration(color: CupertinoColors.white),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(color: CupertinoColors.white),
                height: 119,
                padding: ConstPaddings.constScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 59,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Уведомления'),
                          CupertinoSwitch(
                            value: _switchController,
                            onChanged: (value) {
                              setState(
                                () {
                                  _switchController = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      height: 5,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(LogOutEvent());
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                        child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Выйти',
                              style: ConstTextStyles.constRedTextStyle,
                            ),
                          ),
                          height: 59,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
