import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u3_ga1/provinces.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comarcas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Comarcas'),
        "/provinces": (context) => const ProvincesPage(title: 'Provinces'),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/sun-solid.svg",
                width: 128.0,
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Les comarques de la comunitat",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.0),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Usuari',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Contrasenya',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/provinces");
                  },
                  child: const Text("Next"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
