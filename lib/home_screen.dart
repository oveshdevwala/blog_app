import 'package:clean_architecture_tdd/features/blog/presentation/pages/add_blog.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  List<Widget> pages = [const BlogPage(), const AddBlogPostPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: const [BlogPage(), AddBlogPostPage()],
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          selectedIndex: _pageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(CupertinoIcons.add_circled_solid),
                label: 'Upload Blog'),
          ]),
    );
  }
}
/// ElevatedButton(
                      // onPressed: () async {
                      //   var prefs = await SharedPreferences.getInstance();
                      //   prefs.setString(PrefsConst.userId,'');
                        // var auth = FirebaseAuth.instance;
                        // auth.signOut().then((value) {
                        //   Navigator.pushReplacementNamed(
                        //       context, AppRoute.signIn);
                        // });
                      // },
                      // child: const Text('LogOut'))