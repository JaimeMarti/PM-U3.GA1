import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u3_ga1/config/router/routes.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Comarcas'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
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
                    color: Color(0xFF607090)
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Usuari',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Contrasenya',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push("/provinces");
                      },
                      child: const Text("Log in"),
                    ),
                    TextButton(
                      onPressed: () {
                        Future<RegisterData?> future = registerDialog(context);
                        future.then((data) {
                          if(data != null) {
                            usernameController.text = data.username;
                            passwordController.text = data.password;
                          }
                        });
                      },
                      child: const Text("Register"),
                    )
                  ]
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
  CustomBar(BuildContext context, String title, {super.key}): super(
    backgroundColor: const Color(0x50FFFFFF),
    title: Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Center(child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: "Lobster"),
      ))
    ),
  );
}

Future<RegisterData?> registerDialog(BuildContext context) {
  return showDialog<RegisterData>(
    context: context,
    builder: (BuildContext context) {
      TextEditingController usernameController = TextEditingController();
      TextEditingController passwordController = TextEditingController();

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 230.0
            ),
            child: Column(
              children: [
                const Text(
                  "Registre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Lobster"
                  ),
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Nom d\'usuari',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Contrasenya',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop(RegisterData(
                          username: usernameController.text,
                          password: passwordController.text
                        ));
                      },
                      child: const Text("Registra't"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop(null);
                      },
                      child: const Text("Cancel·la"),
                    )
                  ]
                )
              ],
            )
          )
        )
      );
    }
  );
}

class RegisterData {
  String username;
  String password;

  RegisterData({required this.username, required this.password});
}