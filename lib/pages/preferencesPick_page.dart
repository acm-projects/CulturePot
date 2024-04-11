import 'package:culture_pot/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/pref_buttons.dart';
import 'package:culture_pot/components/pref_buttons2.dart';
class MyPreferences extends StatelessWidget {
  const MyPreferences({super.key});
  
  void userNext(BuildContext context){
    Navigator.pushReplacement(
  context,MaterialPageRoute(builder: (context) => SignSuccess() //here pass the actual values of these variables, for example false if the payment isn't successfull..etc
),);
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:  const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
            const SizedBox(height: 40,),
            //cultural preferences text
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                      "  Cultural preferences 🌍",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter-Regular',
                      ),
                ),
              ),
            
            const SizedBox(height: 15,),
            //cultural picks blurb
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                        "Tell us your cultural preferences, and we will add it to your Culture Pot! Don't worry, you can always change it later in the settings.",
                  
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Alike',
                        ),
                  ),
                ),
              ),

            const SizedBox(height: 30,),
            //row 1
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
              children: [
              const SizedBox(height : 10),
              const SizedBox(width: 5),
                  MyPrefButton(
                    text: 'Mexican 🇲🇽'),
             // const SizedBox(width : 5),
              MyPrefButton(
                text: 'Indian 🇮🇳'),

               MyPrefButton(
                text: 'Eritrean 🇪🇷'),
              //const SizedBox(width: 5,),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            //row 2
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
              children: [
              //const SizedBox(width: 5),
                  MyPrefButton(
                    text: 'France 🇫🇷'),
              const SizedBox(width : 2),
              
              MyPrefButton(
                text: 'Japanese 🇯🇵'),
              
            const SizedBox(width: 5,),
              //const SizedBox(width: 5,),
     
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
              children: [
              const SizedBox(width: 8),
                  MyPrefButton(
                    text: 'Nigerian 🇳🇬'),
              //const SizedBox(width : 8),
              
              MyPrefButton(
                text: 'China 🇨🇳'),
              
              //const SizedBox(width: 8,),
               MyPrefButton(
                text: 'Thailand 🇹🇭'),
              //const SizedBox(width: 8,),
              
                ],
              ),
            ),
            
          const SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
              children: [
              const SizedBox(width: 8),
                  MyPrefButton(
                    text: 'Thailand 🇹🇭'),
              const SizedBox(width : 8),
              
              MyPrefButton(
                text: 'German 🇩🇪'),
              
              //const SizedBox(width: 8,),
              
                ],
              ),
            ),

            const SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
              children: [
            
               MyPrefButton(
                text: 'Others...'),
              const SizedBox(width: 8,),
              
                ],
              ),
            ),
          const SizedBox(height: 80),

           MyPrefButton2(
            onTap: () => userNext(context),
            ),
            ]),
            
        )
      )

    );
  }
}