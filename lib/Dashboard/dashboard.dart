import 'package:customer/TabDashboard/home.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final tabs = [
  //  TabHome(),
  Home(),
   //
   //untuk wallet
    // TabWallet(),
    Home(),
    Home(),
    Home(),
    Home(),
            //
            //untuk history
    // Tab_History(),
            //
            //untuk setting
  //  TabSetting(),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: tabs[
        _selectedIndex
      ],
      // PageView(
      //   controller: pageController,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon:Icon(Icons.home),label:'home'),
          BottomNavigationBarItem( icon:Icon(Icons.map),label:'wallet'),
          BottomNavigationBarItem(icon:Icon(Icons.shopping_basket),label:'history'),
          BottomNavigationBarItem(icon:Icon(Icons.email),label:'setting'),
          BottomNavigationBarItem(icon:Icon(Icons.people),label:'setting'),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.grey[500],
        unselectedItemColor: Colors.grey[350],
      ),
    );
  }
}