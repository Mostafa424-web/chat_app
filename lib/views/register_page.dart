import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubit/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'cubit/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  String? email;
  static String id = 'registerPage';
  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (context , state) {
          if(state is RegisterLoading) {
            isLoading = true;
          }else if(state is RegisterSuccess) {
            isLoading = false;
            Navigator.pushNamed(context, ChatPage.id);
          }else if(state is RegisterFailure){
            showSnackBar(context, state.errorMessage);
            isLoading = false;
          }
        },
      builder: (context , state) {
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
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'pacifico',
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    Row(
                      children: const [
                        Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hint: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      obscureText: true,
                      onChanged: (data) {
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
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email: email!, password: password!);
                        }
                      },
                      text: 'REGISTER',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'already have an account ? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'LoginPage');
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Color(0xffC7EDE6)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
