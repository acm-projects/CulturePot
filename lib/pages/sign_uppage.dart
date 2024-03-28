import 'package:culture_pot/components/my_button2.dart';
import 'package:culture_pot/components/my_textfield.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_button1.dart';
class SignUp extends StatelessWidget {
  SignUp({super.key});
  //text editing controller
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdayController = TextEditingController();
  //sign user up method
  void signUserUp(BuildContext context){
   Navigator.pushReplacement(
  context,MaterialPageRoute(builder: (context) => const MyPreferences() //here pass the actual values of these variables, for example false if the payment isn't successfull..etc
),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              //logo
            
            Image.asset('lib/images/SignIn.png',
            height: 230, 
            ),
            
            const SizedBox(height: 5),
              //Sign UP text
             const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                      "   Sign Up!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter-Regular',
                      ),
                ),
              ),
              //
              const SizedBox(height: 10,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                      "      Create your CulturePot account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'Inter-Regular',
                      ),
                ),
              ),
              //Create Create your CulturePot account. textfield
            const SizedBox(height: 17,),
            //Your name Textfield
            MyTextField(
            controller:  nameController,
            labelText: 'Your Name',
            hintText: 'Name',
            obscureText: false,
            ),
            const SizedBox(height: 20,),

            //write day of birth
            MyTextField(
              controller: birthdayController,
              labelText: 'Date of Birth',
              hintText: 'MM/DD/YYYY',
              obscureText: false,
            ),
            const SizedBox(height: 20,),

              //create username text field
            MyTextField(
              controller: usernameController,
              labelText: 'Create username',
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 20,),

              //retype password text field
            MyTextField(
              controller: passwordController,
              labelText: 'Create password',
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 25,),

              //create account button
            MyButton1(
              onTap:() => signUserUp(context),
            ),
            const SizedBox(height: 20),
            //or continue with
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: Row(
                children: [
                  Expanded(
                    child:Divider(
                thickness: 0.5,
                color:Colors.grey[400],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Or",
                    style: TextStyle(color: Colors.grey,
                    fontFamily: 'Inter-Regular'
                    ),
                  ),
                ),
                Expanded(
                child:Divider(
                thickness: 0.5,
                color:Colors.grey[400],
                ),
                ),
                ],
              ),
            ),
              //or create account with
              //google + apple sign up button
            const SizedBox(height: 15),
            MyButton2(
              onTap: () => signUserUp(context),
            ),
          
          ]),
        ),
      ),
    );
  }
}