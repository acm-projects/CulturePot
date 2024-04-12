import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:culture_pot/components/friendsModel.dart';

class FriendsPage extends StatefulWidget {
  
  @override
  FriendsState createState() => FriendsState();
}

class FriendsState extends State<FriendsPage> {
  bool _isProgressBarShown = true;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<FriendsModel> _listFriends = [];

  @override
  void initState() {
    super.initState();
    _fetchFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partners"),
      ),
      body: _isProgressBarShown
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listFriends.length * 2 - 1,
              itemBuilder: (context, i) {
                if (i.isOdd) return Divider();
                final index = i ~/ 2;
                return _buildRow(_listFriends[index]);
              },
            ),
    );
  }

  Widget _buildRow(FriendsModel friendsModel) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(friendsModel.profileImageUrl),
      ),
      title: Text(
        friendsModel.name,
        style: _biggerFont,
      ),
      trailing: TextButton(
      onPressed: () async {
       setState(() {
        //removefriends
       });
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.yellow,
      ),
      child: const Text(
        'Remove',
        style: TextStyle(color: Colors.black),
      ),
    ),
      subtitle: Text(friendsModel.email),

      onTap: () {
        // go to vieweruser profile by this user
      },
    );
  }

  Future<void> _fetchFriendsList() async {
    setState(() {
      _isProgressBarShown = true;
    });
  //change this url to change partners
    var url = 'https://randomuser.me/api/?results=100&nat=us';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final List<FriendsModel> listFriends = results.map((result) {
          final String name =
              '${result['name']['first']} ${result['name']['last']}';
          final String email = result['email'];
          final String profileUrl = result['picture']['large'];
          return FriendsModel(name, email, profileUrl);
        }).toList();

        setState(() {
          _listFriends = listFriends;
          _isProgressBarShown = false;
        });
      } else {
        throw Exception('Failed to load friends');
      }
    } catch (exception) {
      print(exception.toString());
      setState(() {
        _isProgressBarShown = false;
      });
    }
  }
}
