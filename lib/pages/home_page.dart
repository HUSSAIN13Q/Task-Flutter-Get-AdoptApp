import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:adopt_app/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Pet> pets = Provider.of<PetsProvider>(context).pets;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Adopt"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Add a new Pet"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<PetsProvider>(context, listen: false).getPets();
              },
              child: const Text("GET"),
            ),
            FutureBuilder(  future: context.read<PetsProvider>().getPets(), // Asynchronously fetch pets from PetsProvider
  builder: (context, dataSnapshot) {
    if (dataSnapshot.connectionState == ConnectionState.waiting) {
      // Display loading indicator while waiting for the future to resolve
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (dataSnapshot.error != null) {
        // If an error occurs during fetching, display an error message
        return const Center(
          child: Text('An error occurred'),
        );
      } else {
        // Once the future completes successfully, use Consumer to rebuild the UI when the PetsProvider updates
        return Consumer<PetsProvider>(
          builder: (context, petsProvider, child) => GridView.builder(
            shrinkWrap: true, // Allows GridView to size itself based on content
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Display 2 columns in the grid
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height), // Adjusts item ratio based on device size
            ),
            physics: const NeverScrollableScrollPhysics(), // Prevents the grid from being scrollable
            itemCount: petsProvider.pets.length, // Number of pets to display in the grid
            itemBuilder: (context, index) => PetCard(
              pet: petsProvider.pets[index], // Build each pet's card using PetCarD widget
              )));
                    
              }
               }
  }
            ),
          
              
          ],
        ),
      ),
    );
  }
}
