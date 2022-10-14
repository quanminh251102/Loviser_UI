import 'package:flutter/material.dart';
import 'package:loviser/pages/forget_password_page.dart';
import 'package:loviser/pages/job_detail.dart';
import 'package:loviser/pages/login_page.dart';
import 'package:loviser/pages/post_option_page.dart';
import 'package:loviser/pages/post_to_find_page.dart';
import 'package:loviser/pages/reset_pass_confirm_page.dart';
import 'package:loviser/pages/reset_pass_page.dart';
import 'package:loviser/pages/search_option.dart';
import 'package:loviser/pages/verify_page.dart';
import 'package:loviser/pages/welcome1_page.dart';
import 'package:loviser/pages/welcome_page.dart';
import 'package:loviser/providers/page/message_page/message_page_provider.dart';
import 'package:loviser/widgets/custom_dialog/success_dialog.dart';
import '../pages/home_page.dart';
import '../pages/bookmark_page.dart';
import '../pages/message_page.dart';
import '../pages/notification_page.dart';
import '../pages/login_page.dart';

import './providers/posts.dart';
import './providers/post_filters.dart';
import './providers/applys.dart';
import './providers/authentication.dart';
import './providers/profiles.dart';
import './providers/saved_posts.dart';
import './providers/users.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './pages/applications.dart';

final screens = [];
void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Posts(),
        ),
        ChangeNotifierProvider.value(
          value: PostFilters(),
        ),
        ChangeNotifierProvider.value(
          value: Applys(),
        ),
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
        ChangeNotifierProvider.value(
          value: Profiles(),
        ),
        ChangeNotifierProvider.value(
          value: SavedPosts(),
        ),
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: MessagePageProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: Login(),
        debugShowCheckedModeBanner: false,
      )));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final screens = [
    const HomePage(),
    MessagePage(),
    BookmarkPage(),
    NotificationPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Color clickedItem = Colors.red;
    Color nonClickItem = Colors.grey;

    return Scaffold(
      body: SafeArea(child: screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: Colors.grey,
              ),
              label: 'Trang chủ',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: Colors.grey,
            ),
            label: 'Tin nhắn',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outlined,
              color: Colors.grey,
            ),
            label: 'Đánh dẫu',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            label: 'Thông báo',
          ),
        ],
      ),
    );
  }
}
