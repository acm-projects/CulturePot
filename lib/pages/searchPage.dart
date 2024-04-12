import 'package:culture_pot/pages/homepage.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/searchPref.dart';
import 'package:page_transition/page_transition.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Page"),
          actions: [
            IconButton(
              onPressed: (){
                showSearch(
                  context: context,
                 delegate: CustomSearchDelegate(),
                 );
              }, 
              icon: const Icon(Icons.search), iconSize: 35,)
          ],
          ),
          body: SafeArea(
            child:Center(
              child: Column(
                children: <Widget>[
                 const SizedBox(height : 60),
                  MySearchPrefButton(
                    onTap: ()=> Navigator.of(context).push(PageTransition(
                child: PreferencesPage(),
                type: PageTransitionType.fade)),
            ),
              const SizedBox(height : 25),
                MySearchPrefButton2(onTap: ()=> Navigator.of(context).push(PageTransition(
                child: MyHome(),
                type: PageTransitionType.fade)),
                ),
                const SizedBox(height: 25,),
                MySearchPrefButton3(
                  onTap: ()=> Navigator.of(context).push(PageTransition(
                child: UserProfilePage(),
                type: PageTransitionType.fade)),
                )
                ],
              ),
            ),
            ),
          
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  List <String> searchTerms = [
    'apple',
    'banana',
    'pear',
    'watermelon',
    'oranges',
  ];
  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(onPressed: (){
        query = '';
      }, 
      icon: const Icon(Icons.clear))
    ];
  }
  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
    icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
       );
  }
  @override
  Widget buildResults(BuildContext context){
    List<String> matchQuery = [];
    for(var partners in searchTerms){
      if(partners.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(partners);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
      );
  }

  @override
  Widget buildSuggestions(BuildContext context){
      List<String> matchQuery = [];
    for(var partners in searchTerms){
      if(partners.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(partners);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
      );
  }

}