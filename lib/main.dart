import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/backend/firebase_options.dart';
import 'view/onboarding/boarding/splash_screen.dart';
import 'view_model/bloc/emailverification/emailverification_bloc.dart';
import 'view_model/bloc/signin_bloc/signin_bloc.dart';
import 'view_model/bloc/signup_bloc/signup_bloc.dart';
import 'view_model/checkbox_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SigninBloc()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => EmailVerificationBloc()),
        // Add more Bloc providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turf Booking Application For Owners',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
