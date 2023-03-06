import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/view/screens/home/home.dart';
import 'package:chat_app/view/screens/inbox/inbox.dart';
import 'package:chat_app/view/screens/profile/profile.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  List<Widget> pages = const [Home(), Inbox(), Profile()];
  int _selectedIndex = 0;

  @override
  void initState() {
    ChatController.to.initSocket();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ChatController.to.offlineUser();
    }
    if (state == AppLifecycleState.resumed) {
      ChatController.to.onlineUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FFIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FFIcons.email),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(FFIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
