import 'package:culture_pot/components/my_textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  //text editing controller
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdayController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              //logo
            

              const SizedBox(height: 50),
              //Sign UP text
             const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                      "   Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Inter-Regular',
                      ),
                ),
              ),
              //
              const SizedBox(height: 5,),
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
            const SizedBox(height: 10,),
            //Your name Textfield
            MyTextField(
            controller:  nameController,
            hintText: 'Your Name ',
            obscureText: false,
            ),
            const SizedBox(height: 15,),

            //write day of birth
            MyTextField(
              controller: birthdayController,
              hintText: 'Date of Birth',
              obscureText: false,
            ),
            const SizedBox(height: 15,),

              //create username text field
            MyTextField(
              controller: usernameController,
              hintText: 'Create username',
              obscureText: false,
            ),
            const SizedBox(height: 15,),

              //retype password text field
            MyTextField(
              controller: passwordController,
              hintText: 'Create password',
              obscureText: true,
            ),
            const SizedBox(height: 15,),

              //create account button
          
              //or create account with
          
              //google + apple sign up button
          
          
          ]),
        ),
      ),
    );
  }
}