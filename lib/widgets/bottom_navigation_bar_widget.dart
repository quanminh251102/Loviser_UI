import 'package:flutter/material.dart';

int currentIndex = 0;
Widget bottomNavigationBar() => BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => {currentIndex = index},
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
    );
