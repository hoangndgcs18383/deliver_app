import 'package:deliver_app/screens/account/account_page.dart';
import 'package:deliver_app/screens/auth/sign_in_page.dart';
import 'package:deliver_app/screens/auth/sign_up_page.dart';
import 'package:deliver_app/screens/cart/cart_history.dart';
import 'package:deliver_app/screens/home/main_food_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  late PersistentTabController _controller;



  List pages = [
    MainFoodPage(),
    Container(),
    CartHistory(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectIndex = index;
    });
  }

    @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      SignInPage(),
      CartHistory(),
      AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainFoodPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.yellowColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedFontSize: 0.0,
        selectedFontSize: 0.0,
        onTap: onTapNav,
        currentIndex: _selectIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.archive),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.shopping_cart),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.person),
              label: "home"
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style14, // Choose the nav bar style with this property.
    );
  }
}
