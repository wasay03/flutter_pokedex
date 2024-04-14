import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/pokemon.dart';
import 'provider/pokemon_provider.dart';
import 'pokemon_details_screen.dart'; // Import your destination screen file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PokemonProvider>(
      create: (context) => PokemonProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Pokedex'),
        
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PokemonProvider>(context, listen: false).getAllPokemons();
    });
  }

  void _showTodoDetails(BuildContext context, Pokemon pokemon) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double screen_width = MediaQuery.of(context).size.width;
        return Container(
          width: screen_width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${pokemon.id}'),
              Text('Name: ${pokemon.name}'),
              Text('Height: ${pokemon.height}')
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Consumer<PokemonProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const CircularProgressIndicator();
            } else {
              final pokemons = value.pokemons;
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  pokemons.length,
                  (index) {
                    final pokemon = pokemons[index];
                    Color bg_color;

                        switch (pokemon.type.first) {
                          case "Fire":
                            bg_color = Colors.red;
                            break;
                          case "Grass":
                            bg_color = Colors.green.shade700;
                            break;
                          case "Normal":
                            bg_color = Colors.grey;
                            break;
                          case "Poison":
                            bg_color = Colors.purple;
                            break;
                          case "Electric":
                            bg_color = Colors.yellow;
                            break;
                          case "Water":
                            bg_color = Colors.blue;
                            break;
                          case "Ground":
                            bg_color = Colors.brown;
                            break;
                          case "Bug":
                            bg_color = Colors.green.shade200;
                            break;
                          case "Fighting":
                            bg_color = Colors.orange;
                            break;
                          case "Psychic":
                            bg_color = Colors.pink;
                            break;
                          case "Rock":
                            bg_color = Colors.brown.shade700;
                            break;
                          case "Ghost":
                            bg_color = Colors.deepPurple.shade700;
                            break;
                          case "Ice":
                            bg_color = Colors.lightBlueAccent;
                            break;
                          case "Dragon":
                            bg_color = Colors.indigo.shade900;
                            break;
                          case "Fairy":
                            bg_color = Colors.pinkAccent;
                            break;
                          default:
                            bg_color = Colors.white; // Default color
                            break;
                        }


                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PokemonDetailsScreen(), // Navigate to PokemonDetailsScreen
                            settings: RouteSettings(
                              arguments: pokemon, // Pass the pokemon data as arguments
                            ),
                          ),
                        );
                      },

                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                        clipBehavior: Clip.antiAlias,
                        color: bg_color,
                        child: AspectRatio(
                          aspectRatio: 10 / 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero  ,
                                  title:Container(
                                    width: double.infinity,
                                    height: 20,
                                    child: Text(
                                      pokemon.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: bg_color.withOpacity(0.2)),
                                        color: bg_color.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      width: double.infinity,
                                      height: 20,
                                      child: Text(
                                        pokemon.type.first,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.network(
                                        pokemon.img,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
