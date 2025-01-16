import 'package:flutter/material.dart';
import 'package:u3_ga1/data.dart';
import 'package:u3_ga1/info_comarca_1.dart';
import 'package:u3_ga1/info_comarca_2.dart';
import 'package:u3_ga1/main.dart';

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
      appBar: CustomBar(context, comarca["comarca"]),
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
