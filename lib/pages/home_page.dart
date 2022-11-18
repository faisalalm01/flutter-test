import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluter_article_app/pages/about_page.dart';
import 'package:fluter_article_app/pages/add_page.dart';
import 'package:fluter_article_app/pages/login_page.dart';
import 'package:fluter_article_app/pages/visitor_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String key = '';
  int index = 1;
  final screens = [
    const MorePage(),
    const AddPage(),
    const AboutPage(),
  ];

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var isLogin = pref.getBool("is_login");
    if (isLogin != null && isLogin == true) {
      setState(() {
        // ignore: unused_local_variable
        String? key = pref.getString('key');
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List of page
    final items = <Widget>[
      const Icon(Icons.format_list_bulleted_rounded, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.amber,
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0))),
              child: CurvedNavigationBar(
                // set duration in animation
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 250),
                // setting background color
                color: Color.fromRGBO(255, 193, 7, 1),
                // setting button hover background color
                buttonBackgroundColor: Color.fromRGBO(255, 193, 7, 1),
                items: items,
                height: 55,
                index: index,
                backgroundColor: Colors.transparent,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
