import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'counties.dart';
import 'main.dart';

class CountyInfo2Page extends StatelessWidget {
  final String title;

  const CountyInfo2Page({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CountyArgs;
    final textStyle = const TextStyle(fontSize: 18);

    return Scaffold(
      appBar: CustomBar(context, args.county["comarca"]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/cloud-sun-rain-solid.svg",
              height: 350
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/temperature-half-solid.svg",
                  height: 28
                ),
                SizedBox(width: 8),
                Text(
                  "5.4°",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF606060)
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/wind-solid.svg",
                  height: 28
                ),
                SizedBox(width: 16),
                Text("9.4km/h", style: textStyle),
                SizedBox(width: 16),
                Text("Ponent←", style: textStyle)
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Població:\nLatitud:\nLongitud:", style: textStyle),
                SizedBox(width: 16),
                Text("${args.county["poblacio"]}\n${args.county["coordenades"][0]}\n${args.county["coordenades"][1]}", style: textStyle)
              ],
            ),
          ],
        ),
      )
    );
  }
}