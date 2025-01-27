import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pet_cubit.dart';
import '../model/pet.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopted Pets History'),
      ),
      body:  BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final adoptedPets = pets.where((pet) => pet.isAdopted).toList();
          return ListView.builder(
            itemCount: adoptedPets.length,
            itemBuilder: (context, index) {
              final pet = adoptedPets[index];
              return ListTile(
                title: Text(pet.name),
                subtitle: Text('Age: ${pet.age} | Price: \$${pet.price}'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(pet.imageUrl),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
