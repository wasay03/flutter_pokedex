import 'package:flutter/material.dart';

import 'model/pokemon.dart';

class PokemonDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pokemon ID: ${pokemon.id}'),
            Text('Name: ${pokemon.name}'),
            Text('Height: ${pokemon.height}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
