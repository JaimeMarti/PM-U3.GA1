import 'package:flutter/material.dart';
import 'package:u3_ga1/counties.dart';
import 'package:u3_ga1/main.dart';
import 'data.dart';

class ProvincesPage extends StatelessWidget {
  final String title;

  const ProvincesPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(context, title),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover
          )
        ),
        height: double.infinity,
        child: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16.0),
                ...provincies["provincies"].map((province) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/counties",
                          arguments: CountiesArgs(province)
                        );
                      },
                      padding: EdgeInsets.all(0),
                      icon: CircleAvatar(
                        backgroundImage: NetworkImage(province["img"]),
                        radius: 80.0,
                        child: Text(
                          province["provincia"],
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontFamily: "Lobster",
                            color: Color(0xFFFFFFFF),
                            shadows: [
                              Shadow(
                                color: Color(0xFF000000),
                                offset: Offset(3.0, 3.0)
                              )
                            ]
                          ),
                        ),
                      )
                    )
                  );
                }).toList()
              ],
            ),
          ),
        ))
      )
    );
  }
}
