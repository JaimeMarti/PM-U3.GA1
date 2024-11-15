import 'package:flutter/material.dart';
import 'package:u3_ga1/main.dart';

class CountiesPage extends StatelessWidget {
  final String title;

  const CountiesPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CountiesArgs;

    return Scaffold(
      appBar: CustomBar(context, "Comarques de ${args.province["provincia"]}"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            ...args.province["comarques"].map((county) {
              return Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/county_info_1",
                      arguments: CountyArgs(county)
                    );
                  },
                  padding: EdgeInsets.all(0.0),
                  icon: Stack(
                  children: [
                    Image.network(
                      county["img"],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 120,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          county["comarca"],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Lobster",
                            color: Color(0xFFFFFFFF),
                            shadows: [
                              Shadow(
                                color: Color(0xFF000000),
                                offset: Offset(2.0, 2.0)
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ]
                ),
                ),
              );
            }).toList()
          ],
        ),
      )
    );
  }
}

class CountiesArgs {
  Map<String, dynamic> province;
  CountiesArgs(this.province);
}

class CountyArgs {
  Map<String, dynamic> county;
  CountyArgs(this.county);
}