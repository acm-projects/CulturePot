import 'package:flutter/material.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:culture_pot/pages/comment_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/components/save_button.dart';
//import 'package:culture_pot/components/comment_sheet.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLiked = false;
  int _selectedIndex = 0;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 233, 230, 230),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            color: const Color.fromARGB(255, 247, 192, 25),
            activeColor: Colors.black,
            gap: 6,
            tabBackgroundColor: const Color.fromARGB(167, 247, 192, 25),
            padding: const EdgeInsets.all(12),
            tabs: const [
              GButton(icon: Icons.home, iconSize: 30, text: 'Home'),
              GButton(
                  icon: Icons.book_outlined, iconSize: 30, text: 'Cultures'),
              GButton(
                icon: Icons.location_on_outlined,
                text: 'Map',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
                iconSize: 30,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                switch (index) {
                  case 0:
                    // Navigator.of(context).push(PageTransition(
                    //     child: MyHome(), type: PageTransitionType.fade));
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferencesPage(),
                      ),
                    );
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferencesPage(),
                      ),
                    );
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfilePage(),
                      ),
                    );
                }
              });
            },
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      appBar: AppBar(
        title: Image.asset('imagespot/logo.png', height: 90),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('imagespot/pfpReal.jpeg'),
                        radius: 18,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewerProfilePage(),
                            ),
                          );
                        },
                        child: const Text(
                          '@username',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 200), // Adjust the spacing between icons
                      SaveButton(
                        isSaved: isSaved,
                        onTap: () {
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset('imagespot/postEx.png'),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: const Text(
                    'My family and I visited the Statue of Unity in Gujarat, India this spring for the first time. I was fascinated at the way locals spoke dialect X of Gujarati while we tourists spoke and learned in dialect Y. Does anyone know why that is?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.comment,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageRouteBuilder(
                          widget: const CommentPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewerProfilePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'vidurnangia',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'and 12 other Partners',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              //CommentSheet(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 247, 192, 25),
        child: Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // No need to navigate to the same page
        break;
      case 1:
        // Navigate to Cultures page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 2:
        // Navigate to Map page
        // Replace PreferencesPage with your desired page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 3:
        // Navigate to Profile page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
        break;
      default:
    }

    // Update tab color after navigation
    setState(() {
      _selectedIndex = index;
    });
  }
}

class CustomPageRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget widget;

  CustomPageRouteBuilder({required this.widget})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0), // Slide up from bottom
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
        );
}
