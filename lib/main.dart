import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:new_test/bloc/auth/auth_bloc.dart';
import 'package:new_test/consts/colors.dart';
import 'package:new_test/core/injections.dart';
import 'package:new_test/ui/screens/auth_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tokens');
  setupInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(CheckAuthEvent()),
        ),
      ],
      child: CupertinoApp(
        title: 'Material App',
        home: AuthScreen(),
      ),
    );
  }
}
