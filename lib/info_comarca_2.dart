import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountyInfo2Page extends StatelessWidget {
  final Map<String, dynamic> county;

  const CountyInfo2Page({super.key, required this.county});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18);

    return Padding(
      padding: const EdgeInsets.all(16),
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
              const SizedBox(width: 8),
              const Text(
                "5.4°",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF606060)
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/wind-solid.svg",
                height: 28
              ),
              const SizedBox(width: 16),
              const Text("9.4km/h", style: textStyle),
              const SizedBox(width: 16),
              const Text("Ponent←", style: textStyle)
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("Població:\nLatitud:\nLongitud:", style: textStyle),
              const SizedBox(width: 16),
              Text("${county["poblacio"]}\n${county["coordenades"][0]}\n${county["coordenades"][1]}", style: textStyle)
            ],
          ),
        ],
      ),
    );
  }
}