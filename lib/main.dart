import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/views/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginPage' : (context) =>   LoginPage(),
          RegisterPage.id : (context) =>   RegisterPage(),
          ChatPage.id : (context) => ChatPage(),
        },
        initialRoute: 'LoginPage',
      ),
    );
  }
}
