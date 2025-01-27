import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pet_cubit.dart';
import '../utils/constant.dart';
import '../model/pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PetCubit>().loadPets();
  }

  void _onSearchChanged(String query) {
    context.read<PetCubit>().searchPets(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Constant.petAdoptApp),
            SizedBox(
              width: 110,
              height: 30,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, Constant.history);
                },
                icon: const Icon(Icons.history_edu, size: 20),
                label: const Text(Constant.historyTitle),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  side: const BorderSide(color: Colors.white, width: 1),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Pets',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),
          BlocBuilder<PetCubit, List<Pet>>(
            builder: (context, pets) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return ListTile(
                      title: Text(pet.name),
                      subtitle: Text('Age: ${pet.age} | Price: \$${pet.price}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(pet.imageUrl),
                      ),
                      trailing: pet.isAdopted
                          ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, Constant.history);
                        },
                        icon: const Icon(Icons.check, size: 20),
                        label: const Text('Already Adopted'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          side: const BorderSide(color: Colors.white, width: 1),
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                      )
                          : null,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Constant.detailsPage,
                          arguments: pet,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
