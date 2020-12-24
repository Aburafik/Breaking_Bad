import 'package:breaking_bad/screens/character_screen.dart';
import 'package:breaking_bad/screens/quotes_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Scaffold(
          body: PageViewer(),
        )

        // QuotesScreen(),

        // CharacterScreen(),
        );
  }
}

class PageViewer extends StatefulWidget {
  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  onPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        children: [CharacterScreen(), QuotesScreen()],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        // backgroundColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Characters'),
          BottomNavigationBarItem(icon: Icon(Icons.format_quote), label: 'Quotes',),
        ],
        onTap: onTap,
        currentIndex: pageIndex,
        activeColor: Colors.teal,
      ),
    );
  }
}
