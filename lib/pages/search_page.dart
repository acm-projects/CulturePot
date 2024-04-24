import 'package:culture_pot/pages/home.dart';
//import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/searchPref.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});
  
  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
    int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 230, 230),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 233, 230, 230),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            color: Color.fromARGB(255, 247, 192, 25),
            activeColor: Colors.black,
            gap: 6,
            tabBackgroundColor: Color.fromARGB(167, 247, 192, 25),
            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(icon: Icons.home, iconSize: 30, text: 'Home'),
              GButton(
                  icon: Icons.book_outlined, iconSize: 30, text: 'Cultures'),
              GButton(
                icon: Icons.search_rounded,
                text: 'Search',
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
                    Navigator.of(context).push(PageTransition(
                        child: MyHome(), type: PageTransitionType.fade));
                    break;
                  case 1:
                    Navigator.of(context).push(PageTransition(
                        child: PreferencesPage(),
                        type: PageTransitionType.fade));
                    break;
                  case 2:
                    Navigator.of(context).push(PageTransition(
                        child:MySearchPage(), type: PageTransitionType.fade));
                    break;
                  case 3:
                    Navigator.of(context).push(PageTransition(
                        child: UserProfilePage(),
                        type: PageTransitionType.fade));
                    break;
                }
              });
            },
          ),
        ),
      ),
  appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 233, 230, 230),
  automaticallyImplyLeading: false,
  title: Text("Search Page"),
  actions: [
    IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      icon: const Icon(Icons.search),
      iconSize: 35,
    )
  ],
),

        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 60),
                MySearchPrefButton(
                  onTap: () => Navigator.of(context).push(PageTransition(
                      child: PreferencesPage(), type: PageTransitionType.fade)),
                ),
                const SizedBox(height: 25),
                MySearchPrefButton2(
                  onTap: () => Navigator.of(context).push(PageTransition(
                      child: MyHome(), type: PageTransitionType.fade)),
                ),
                const SizedBox(
                  height: 25,
                ),
                MySearchPrefButton3(
                  onTap: () => Navigator.of(context).push(PageTransition(
                      child: UserProfilePage(), type: PageTransitionType.fade)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Nigerian',
    'Mexican',
    'United States',
    'Indian',
    'German',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var partners in searchTerms) {
      if (partners.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(partners);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var partners in searchTerms) {
      if (partners.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(partners);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
