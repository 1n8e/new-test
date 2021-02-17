import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_test/bloc/category/category_bloc.dart';
import 'package:new_test/consts/colors.dart';
import 'package:new_test/core/injections.dart';
import 'package:new_test/ui/widgets/category_list_view.dart';
import 'package:new_test/ui/widgets/profile_settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List _widgets = [
    CategoryListView(),
    ProfileSettings(),
    Offstage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: ConstColors.constBackgroundColor,
      tabBar: CupertinoTabBar(
        activeColor: Color(0xff172853),
        onTap: _onItemTap,
        backgroundColor: CupertinoColors.white,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/category_icon.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/category_icon.svg',
                color: Color(0xff172853),
              ),
              label: 'Прачечная'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/user_icon.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/user_icon.svg',
                color: Color(0xff172853),
              ),
              label: 'Профиль'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart_icon.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/cart_icon.svg',
              color: Color(0xff172853),
            ),
            label: 'Корзина',
          ),
        ],
      ),
      tabBuilder: (context, int) {
        return CupertinoTabView(
          builder: (context) {
            return _widgets.elementAt(int);
          },
        );
      },
    );
  }
}
