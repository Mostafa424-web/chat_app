import 'package:chat_app/constants.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool isLoading = false;
   String? email;
   String? password;

   GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset('assets/images/scholar.png',height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                     Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32, fontFamily: 'pacifico', color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  children: const [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (data){
                    email = data;
                  },
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscureText: true,
                  onChanged: (data){
                    password = data;
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                 CustomButton(
                   onTap: () async {
                     if (formKey.currentState!.validate()) {
                       isLoading = true;
                       setState(() {

                       });
                       try {
                         await loginUser();
                         Navigator.pushNamed(context, ChatPage.id , arguments: email);
                       }on FirebaseAuthException catch (e) {
                         if(e.code == 'user-not-found'){
                           showSnackBar(context , 'User not found');
                         }else if (e.code == 'wrong-password'){
                           showSnackBar(context, 'Wrong Password');
                         }
                       }catch(e){
                         showSnackBar(context, 'there was an error');
                       }
                       isLoading = false;
                       setState(() {

                       });
                     }
                   },
                   text: 'LOGIN',
                 ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future<void> loginUser() async {
     var auth = FirebaseAuth.instance;

     await auth.signInWithEmailAndPassword(
         email: email!, password: password!);
   }
}
