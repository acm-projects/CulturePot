// import 'package:culture_pot/pages/notifsempty_page.dart';
// import 'package:culture_pot/pages/preferences_page.dart';
// //import 'package:culture_pot/pages/viewer_profile_page.dart';
// import 'package:culture_pot/pages/user_profile_page.dart';
// import 'package:culture_pot/pages/home.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:culture_pot/pages/search_page.dart';

// class Map extends StatefulWidget {
//   const Map({Key? key}) : super(key: key);

//   @override
//   State<Map> createState() => _MapState();
// }

// class _MapState extends State<Map> {
//   int _selectedIndex = 2;

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Color.fromARGB(255, 233, 230, 230), // Set background color
//       bottomNavigationBar: Container(
//         color: Color.fromARGB(255, 233, 230, 230),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
//           child: GNav(
//             backgroundColor: const Color.fromARGB(255, 233, 230, 230),
//             color: Color.fromARGB(255, 247, 192, 25),
//             activeColor: Colors.black,
//             gap: 6,
//             tabBackgroundColor: Color.fromARGB(167, 247, 192, 25),
//             padding: EdgeInsets.all(12),
//             tabs: const [
//               GButton(icon: Icons.home, iconSize: 30, text: 'Home'),
//               GButton(
//                   icon: Icons.book_outlined, iconSize: 30, text: 'Cultures'),
//               GButton(
//                 icon: Icons.location_on_outlined,
//                 text: 'Map',
//                 iconSize: 30,
//               ),
//               GButton(
//                 icon: Icons.person_outline,
//                 text: 'Profile',
//                 iconSize: 30,
//               ),
//             ],
//             selectedIndex: _selectedIndex,
//             onTabChange: (index) {
//               setState(() {
//                 _selectedIndex = index;
//                 switch (index) {
//                   case 0:
//                     Navigator.of(context).push(PageTransition(
//                         child: MyHome(), type: PageTransitionType.fade));
//                     break;
//                   case 1:
//                     Navigator.of(context).push(PageTransition(
//                         child: PreferencesPage(),
//                         type: PageTransitionType.fade));
//                     break;
//                   case 2:
//                     Navigator.of(context).push(PageTransition(
//                         child: MyHome(), type: PageTransitionType.fade));
//                     break;
//                   case 3:
//                     Navigator.of(context).push(PageTransition(
//                         child: const UserProfilePage(
//                           profileImageAsset: "imagespot/pfpReal.jpeg",
//                           username: '@newuser',
//                         ),
//                         type: PageTransitionType.fade));
//                     break;
//                 }
//               });
//             },
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 233, 230, 230),
//         title: Image.asset('imagespot/logo.png', height: 90),
//         leading: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 9.0),
//           child: IconButton(
//             onPressed: () => Navigator.of(context).push(PageTransition(
//                 child: MyNotifsEmpty(), type: PageTransitionType.fade)),
//             icon: const Icon(
//               Icons.favorite_border_rounded,
//               size: 35.0,
//             ),
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MySearchPage()));
//                 },
//                 icon: const Icon(Icons.search_rounded,
//                     color: Colors.black, size: 35.0)),
//           )
//         ],
//       ),

//       //body: backg
//     );
//   }
// }
