import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'info_comarca_1.dart';
import 'info_comarca_2.dart';
import 'counties.dart';
import 'provinces.dart';

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
        "/counties": (context) => const CountiesPage(title: 'Counties'),
        "/county_info_1": (context) => const CountyInfo1Page(title: 'County'),
        "/county_info_2": (context) => const CountyInfo2Page(title: 'County'),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
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
                  style: TextStyle(
                    fontSize: 32.0,
                    fontFamily: "Lobster",
                    color: Color(0xFF0607090)
                  ),
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
        ),
      )
    );
  }
}

class CustomBar extends AppBar {
  CustomBar(BuildContext context, String title): super(
    backgroundColor: Color(0x50FFFFFF),
    title: Padding(
      padding: EdgeInsets.only(right: 50),
      child: Center(child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Lobster"),
      ))
    ),
  );
}