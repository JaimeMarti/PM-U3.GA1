import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:u3_ga1/data.dart';
import 'package:u3_ga1/main.dart';

class CountiesPage extends StatelessWidget {
  final int province;

  const CountiesPage({super.key, required this.province});

  @override
  Widget build(BuildContext context) {
    List<dynamic> comarques = provincies["provincies"][province]["comarques"];
    return Scaffold(
      appBar: CustomBar(
        context, 
        "Comarques de ${provincies["provincies"][province]["provincia"]}"
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            ...Iterable<int>.generate(comarques.length).map((index) {
              Map<String, dynamic> county = comarques[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: IconButton(
                  onPressed: () {
                    context.push("/county/$province/$index");
                  },
                  padding: const EdgeInsets.all(0.0),
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
                        padding: const EdgeInsets.all(8),
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
            })
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