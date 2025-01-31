import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u3_ga1/config/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:u3_ga1/provinces.dart';
import 'package:u3_ga1/util.dart';
import 'firebase_options.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseDatabase database =  FirebaseDatabase.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if(user == null) {
            return const MyHomePage();
          }
          else {
            return const ProvincesPage();
          }
        }
        else {
          return const CircularProgressIndicator();
        }
      },
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
                  obscureText: true
                ),
                const SizedBox(height: 16.0),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        //context.push("/provinces");
                        loadingDialog(
                          context,
                          auth.signInWithEmailAndPassword(
                            email: usernameController.text,
                            password: passwordController.text
                          )
                        );
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
  CustomBar(BuildContext context, String title, {super.leading, super.actions, super.actionsIconTheme, super.key}): super(
    backgroundColor: const Color(0x50FFFFFF),
    title: Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Center(child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: "Lobster"),
      ))
    )
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                obscureText: true
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      loadingDialog(
                        context,
                        auth.createUserWithEmailAndPassword(
                          email: usernameController.text,
                          password: passwordController.text
                        )
                      ).then((credentials) {
                        if(credentials != null) {
                          context.pop(null);
                        }
                      });
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
      );
    }
  );
}

class RegisterData {
  String username;
  String password;

  RegisterData({required this.username, required this.password});
}