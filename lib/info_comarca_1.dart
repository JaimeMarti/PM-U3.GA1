import 'package:flutter/material.dart';
import 'package:u3_ga1/main.dart';
import 'counties.dart';

class CountyInfo1Page extends StatelessWidget {
  final String title;

  const CountyInfo1Page({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CountyArgs;

    return Scaffold(
      appBar: CustomBar(context, args.county["comarca"]),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(args.county["img"]),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.county["comarca"],
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF606060)
                  ),
                ),
                Text(
                  "Capital: ${args.county["capital"]}",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 16),
                Text(args.county["desc"])
              ],
            ),
          )
        ],
      ))
    );
  }
}