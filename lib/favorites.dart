import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:u3_ga1/data.dart';
import 'package:u3_ga1/main.dart';
import 'package:u3_ga1/util.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(
        context, 
        "Favorites"
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
        child: StreamBuilder(
          stream: getFavoritesStream(),
          builder: (context, snapshot) {
            Iterable<CountyId>? countyIds = snapshot.data;
            if(countyIds != null) {
              return ListView(
                children: [
                  const SizedBox(height: 16.0),
                  ...countyIds.map((id) {
                    Map<String, dynamic> province = provincies["provincies"][id.province];
                    Map<String, dynamic> county = province["comarques"][id.county];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: IconButton(
                        onPressed: () {
                          context.push("/county/${id.province}/${id.county}");
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
                                  "${county["comarca"]} - ${province["provincia"]}",
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
                ]
              );
            }
            else if(snapshot.error != null) {
              return Text(snapshot.error.toString());
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        )
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