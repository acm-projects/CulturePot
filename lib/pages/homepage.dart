import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/components/post.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    backgroundColor:  const Color.fromARGB(255, 233, 230, 230),
      bottomNavigationBar: 
      Container(
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
           
            tabs: const[
              GButton(icon: Icons.home,
              iconSize: 30,
              text: 'Home'
              ),
              GButton(icon: Icons.book_outlined, 
              iconSize: 30,
              text: 'Cultures'),
              GButton(icon: Icons.location_on_outlined, 
              text: 'Map',
              iconSize: 30,),
              GButton(icon: Icons.person_outline, 
              text: 'Profile',iconSize: 30,),
            ],
             selectedIndex: _selectedIndex,
            onTabChange: (index){
               setState(() {
                  _selectedIndex = index;
                });
            },
          ),
        ),
      ),

      appBar: 
      AppBar(
      
      backgroundColor:  Color.fromARGB(255, 233, 230, 230),
      title: Image.asset('lib/images/logo.png', height: 90),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.favorite_border_rounded, size: 35.0,) ,
              ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 18.0),
              child: IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.search_rounded, color: Colors.black, size: 35.0)),
            )
          ],
        ),
     body: Stack(
    alignment: Alignment.center ,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 10),
            Post(),
            const SizedBox(height: 12),
              Post(),
            ],
            ),
            ),
        )
      ],
      ),
    );
  
  }
}