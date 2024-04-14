import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'model/pokemon.dart';
import 'main.dart';

class PokemonDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation=2;
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Details'),
      ),
      body: Center(
        child:
    Column(
        children: [
          Container(
            color: pokemon.bg_color,
            child: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pokemon.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const Spacer(), // This will occupy the available space
          Text(
            "#${pokemon.id}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                pokemon.type.first,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [

            Hero(
              tag: 'pokemonImage_${pokemon.id}',
              child: Image.network(
                pokemon.img,
                height: 250,
              ),
            )
          ])
        ,
      
       Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)), color: Colors.grey.shade200),
        width: double.maxFinite,
        height: 480,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Name'),
                const SizedBox(width: 70),
                Text(pokemon.name),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Height'),
                const SizedBox(width: 66),
                Text(pokemon.height),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Weight'),
                const SizedBox(width: 64),
                Text(pokemon.weight),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Spawn Time'),
                const SizedBox(width: 30),
                Text(pokemon.spawnTime.toString()),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Weaknesses'),
                const SizedBox(width: 28),
                Text(
                  pokemon.weaknesses.join(', '),
                ), // Replace with actual weaknesses
              ],
            ),
            if (pokemon.prevEvolution?.isNotEmpty == true)
              Row(
                children: [
                  const Text('Pre Evolution'),
                  const SizedBox(width: 24),
                  Text(
                    pokemon.prevEvolution!
                        .map((e) => e.name)
                        .join(', '), // Replace with actual pre-evolution
                  ),
                ],
              ),
            if (pokemon.prevEvolution == null &&
                pokemon.nextEvolution?.isNotEmpty == true)
              const SizedBox(height: 12),
            if (pokemon.nextEvolution?.isNotEmpty == true)
              Row(
                children: [
                  const Text('Next Evolution'),
                  const SizedBox(width: 16),
                  Text(
                    pokemon.nextEvolution!
                        .map((e) => e.name)
                        .join(', '), // Replace with actual next-evolution
                  ),
                ],
              ),
          ],
        ),
      ),])
    ),);}}
  