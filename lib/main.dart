import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynah_test/presentation/bloc/auth/auth_cubit.dart';
import 'package:paynah_test/presentation/bloc/profile/profile_cubit.dart';
import 'package:paynah_test/presentation/screens/choose_account_screen.dart';
import 'package:paynah_test/presentation/screens/on_boarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paynah_test/utils/utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
        BlocProvider(create: (context) => AuthCubit(FirebaseAuth.instance),),
        BlocProvider(create: (context) => ProfileCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Paynah',
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colors.black,
            secondary: Colors.grey,
          ),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const ChooseAccountScreen(); 
            } else if (state is AuthUnauthenticated) {
              return const OnBoardingScreen(); 
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()), 
              );
            }
          },
        ),
      ),
    );
  }
}
