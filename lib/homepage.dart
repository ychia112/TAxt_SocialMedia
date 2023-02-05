import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'pages/home.dart';
import 'pages/post.dart';
import 'pages/profile.dart';
import 'pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  var _pageController = PageController();

  final List<Widget> _pages = [
    UserProfile(),
    UserHome(),
    UserPost(),
    Search(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: _pages,
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal:24),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: GNav(
            onTabChange: (index){
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(_selectedIndex, duration: Duration(milliseconds: 900), curve: Curves.easeOutQuint);
              });
            },
            selectedIndex: _selectedIndex,
            padding: EdgeInsets.symmetric(horizontal:15, vertical:10),
            backgroundColor: Colors.transparent,
            color: Colors.white60,
            activeColor: Colors.white,
            iconSize: 20,
            tabBackgroundColor: Colors.grey.shade900,
            gap: 3,
            tabs: const[
              GButton(
                icon: Icons.account_box_rounded,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.house_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.add_box_outlined,
                text: 'Post',
              ),
              GButton(
                icon: Icons.search_rounded,
                text: 'Search',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
