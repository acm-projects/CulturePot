import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:page_transition/page_transition.dart';
class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => FriendsListState();
}

class FriendsListState extends State<FriendsList> {
  List<Contact> contacts = [];

  @override
  void initState(){
    super.initState();
    getAllContacts();
  }
  getAllContacts() async{
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails:false)).toList();  
    setState(() {
      contacts = _contacts;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Partner List"),
        leading: IconButton(
          onPressed: ()=> Navigator.of(context).push(PageTransition(
                child: UserProfilePage(),
                type: PageTransitionType.fade)),
          icon:  Icon(Icons.arrow_back),
          )
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child : Text("Laalalla"),
            ),
            Expanded(
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index){
            Contact contact = contacts[index];
                return const ListTile(
                  title: Text("Leila <3"),
                  subtitle: Text(
                    "@leila5678"
                  ) ,
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("lib/images/pfpKenzo.jpeg"),
                    ),
                );
              }
              )
            )
          ],
        ),
      )
    );
  }
}