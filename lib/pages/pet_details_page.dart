import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pet_cubit.dart';
import '../model/pet.dart';
import 'image_viewer.dart';

class PetDetailsPage extends StatelessWidget {


  const PetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context)!.settings.arguments as Pet;
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: pet.name,
              child: GestureDetector(
                child: Image.asset(pet.imageUrl),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(imageUrl: pet.imageUrl,petName: pet.name,),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text('Age: ${pet.age}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Price: \$${pet.price}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            BlocBuilder<PetCubit, List<Pet>>(
                builder: (context, pets) {
                return ElevatedButton(
                  onPressed: pet.isAdopted
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("You’ve adopted ${pet.name}")),
                          );
                          BlocProvider.of<PetCubit>(context).adoptPet(pet);
                        },
                  child: Text(pet.isAdopted ? 'Already Adopted' : 'Adopt Me'),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}


