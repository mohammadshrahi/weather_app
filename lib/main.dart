import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/pages/home_page.dart';

void main() {
  configureDependencies(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(value: getIt.get<LocationBloc>()),
          BlocProvider.value(value: getIt.get<HomePageBloc>())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConst.kMaterialAppTitle,
          theme: AppConst.getAppThem(),
          home: HomePage(),
        ));
  }
}
