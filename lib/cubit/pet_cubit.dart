import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/pet.dart';

class PetCubit extends Cubit<List<Pet>> {
  PetCubit() : super([]) ;

  List<Pet> pets = [];


  /// Load pets and adopt status from SharedPreferences
  Future<void> loadPets() async {
    final prefs = await SharedPreferences.getInstance();
    pets = [
      Pet(
        name: 'Buddy',
        age: 3,
        price: 250.0,
        isAdopted: prefs.getBool('Buddy') ?? false,
        imageUrl: 'assets/images/pet1.jpeg',
      ),
      Pet(
        name: 'Mittens',
        age: 2,
        price: 150.0,
        isAdopted: prefs.getBool('Mittens') ?? false,
        imageUrl: 'assets/images/pet2.jpeg',
      ),
      Pet(
        name: 'monkey',
        age: 5,
        price: 350.0,
        isAdopted: prefs.getBool('monkey') ?? false,
        imageUrl:
        'assets/images/pet4.jpeg',),
      Pet(
        name: 'Doggy',
        age: 5,
        price: 350.0,
        imageUrl:
        'assets/images/pet3.jpeg',),
      Pet(
        name: 'Vodafone Doggy',
        age: 5,
        price: 350.0,
        imageUrl:
        'assets/images/pet1.jpeg',),

    ];
    emit(pets);
  }


  Future<void> adoptPet(Pet pet) async {
    final prefs = await SharedPreferences.getInstance();
    pet.isAdopted = true;
    /// Persist the adoption status in SharedPreferences
    await prefs.setBool(pet.name, true);
    /// Emit the updated list of pets to update UI
    final updatedPets = List<Pet>.from(state);
    emit(updatedPets);
  }
/// added search functionality
  void searchPets(String query) {
    if (query.isEmpty) {
      emit(pets);
    } else {
      final filteredPets = pets
          .where((pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(filteredPets);
    }
  }
}
