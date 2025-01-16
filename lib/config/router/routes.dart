import 'package:go_router/go_router.dart';
import 'package:u3_ga1/counties.dart';
import 'package:u3_ga1/info_comarca.dart';
import 'package:u3_ga1/main.dart';
import 'package:u3_ga1/provinces.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      name: 'provinces',
      path: '/provinces',
      builder: (context, state) => const ProvincesPage(),
    ),
    GoRoute(
      name: 'counties',
      path: '/counties/:province',
      builder: (context, state) {
        int province = int.parse(state.pathParameters['province']!);
        return CountiesPage(province: province);
      }
    ),
    GoRoute(
      name: 'county',
      path: '/county/:province/:county',
      builder: (context, state) {
        int province = int.parse(state.pathParameters['province']!);
        int county = int.parse(state.pathParameters['county']!);
        return CountyInfo(province: province, county: county);
      }
    )
  ],
);
