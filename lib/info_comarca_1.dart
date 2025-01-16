import 'package:flutter/material.dart';

class CountyInfo1Page extends StatelessWidget {
  final Map<String, dynamic> county;

  const CountyInfo1Page({super.key, required this.county});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(county["img"]),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                county["comarca"],
                style: const TextStyle(
                  fontSize: 28,
                  color: Color(0xFF606060)
                ),
              ),
              Text(
                "Capital: ${county["capital"]}",
                style: const TextStyle(
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 16),
              Text(county["desc"])
            ],
          ),
        )
      ],
    ));
  }
}