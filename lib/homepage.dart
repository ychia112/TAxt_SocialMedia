import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'pages/diary.dart';
import 'pages/profile.dart';
import 'pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pageController = PageController();

  late final List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      UserProfile(address: context.read<MetaMask>().getAddress(), viewByOwner: true, isSearchPage: false,),
      const UserHome(),
      DiaryPage(),
      const Search(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal:24),
          decoration: const BoxDecoration(
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
            padding: const EdgeInsets.symmetric(horizontal:15, vertical:10),
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
                icon: Icons.book_rounded,
                text: 'Diary',
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