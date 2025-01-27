import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/constant.dart';
import 'cubit/pet_cubit.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/pet_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetCubit()..loadPets(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constant.petAdoptApp,
        theme: ThemeData.dark(),
        initialRoute: Constant.home,
        routes: {
          Constant.home: (context) => const HomePage(),
          Constant.history: (context) => const HistoryPage(),
          Constant.detailsPage: (context) => const PetDetailsPage(),
        },
      ),
    );
  }
}
