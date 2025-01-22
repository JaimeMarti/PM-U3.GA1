import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class CountyInfo2Page extends StatefulWidget {
  final Map<String, dynamic> county;
  late Future<Map<String, dynamic>> futureWeather;

  CountyInfo2Page({super.key, required this.county}) {
    futureWeather = fetchWeather(county["coordenades"][0], county["coordenades"][1]);
  }

  @override
  State<CountyInfo2Page> createState() => _CountyInfo2PageState();
}

class _CountyInfo2PageState extends State<CountyInfo2Page> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder(
        future: widget.futureWeather,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          else if(snapshot.hasData) {
            Map<String, dynamic> weather = snapshot.data!["current"];
            bool isDay = weather["is_day"] == 1;
            String time = isDay ? "sun" : "moon";
            String icon;
            if(weather["precipitation"] > 0.1) {
              icon = "cloud-$time-rain-solid";
            }
            else if(weather["cloud_cover"] > 50) {
              icon = "cloud-$time-solid";
            }
            else {
              icon = "$time-solid";
            }
            return Column(
              children: [
                SvgPicture.asset(
                  "assets/$icon.svg",
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
                    Text(
                      "${weather["temperature_2m"]}°",
                      style: const TextStyle(
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
                    Text("${weather["wind_speed_10m"]} km/h", style: textStyle)
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Població:\nLatitud:\nLongitud:", style: textStyle),
                    const SizedBox(width: 16),
                    Text("${widget.county["poblacio"]}\n${widget.county["coordenades"][0]}\n${widget.county["coordenades"][1]}", style: textStyle)
                  ],
                ),
              ],
            );
          }
          else {
            return const Center(child: Text("No data found"));
          }
        },
      )
    );
  }
}

Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
  final response = await http.get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,wind_speed_10m,precipitation,cloud_cover,is_day&timezone=Europe%2FBerlin"));
  if(response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  else {
    throw Exception("Failed to load weather");
  }
}