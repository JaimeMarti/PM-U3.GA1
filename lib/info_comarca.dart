import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u3_ga1/data.dart';
import 'package:u3_ga1/info_comarca_1.dart';
import 'package:u3_ga1/info_comarca_2.dart';
import 'package:u3_ga1/main.dart';
import 'package:u3_ga1/util.dart';

class CountyInfo extends StatefulWidget {
  final int province;
  final int county;
  
  const CountyInfo({super.key, required this.province, required this.county});

  @override
  State<CountyInfo> createState() =>
      _CountyInfoState();
}

class _CountyInfoState
    extends State<CountyInfo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> comarca = provincies["provincies"][widget.province]["comarques"][widget.county];
    List<Widget> pages = [
      CountyInfo1Page(county: comarca),
      CountyInfo2Page(county: comarca)
    ];
    return Scaffold(
      appBar: CustomBar(
        context, 
        comarca["comarca"],
        actions: [
          StreamBuilder(
            stream: isFavoriteStream(widget.province, widget.county),
            builder: (context, snapshot) {
              bool? isFavorite = snapshot.data;
              if(isFavorite != null) {
                if(isFavorite) {
                  return IconButton(
                    icon: SvgPicture.asset(
                      "assets/heart-crack-solid.svg",
                      width: 34.0
                    ),
                    onPressed: () {
                      loadingDialog(
                        context,
                        removeFavorite(widget.province, widget.county)
                          .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("La comarca ha sido eliminada de la lista de favoritos")
                            ));
                          })
                      );
                    },
                  );
                }
                else {
                  return IconButton(
                    icon: SvgPicture.asset(
                      "assets/heart-solid.svg",
                      width: 34.0
                    ),
                    onPressed: () {
                      loadingDialog(
                        context,
                        addFavorite(widget.province, widget.county)
                          .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("La comarca se ha añadido a la lista de favoritos")
                            ));
                          })
                      );
                    },
                  );
                }
              }
              else if(snapshot.error != null) {
                return const Text("Error");
              }
              else {
                return const CircularProgressIndicator();
              }
            },
          )
        ]
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // El índice de la pestaña seleccionada
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Cambia la pestaña seleccionada
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informació',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'El temps',
          )
        ],
      ),
    );
  }
}
