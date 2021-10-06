import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mockitail;
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import '../../utils/bloc_utils.dart';
import '../../utils/blocs/blocs.dart';
import 'package:weather_app/domain/entities/weather_item.dart';

void main() {
  group('Home page', () {
    setUpAll(() {
      mockitail.registerFallbackValue<LocationState>(
          BlocUtils.kLocationSuccessState);
      mockitail
          .registerFallbackValue<HomePageState>(BlocUtils.homePageSuccessState);
      mockitail.registerFallbackValue<HomePageEvent>(HomePageWeatherGet(123));
      mockitail.registerFallbackValue<LocationEvent>(LocationGetEvent());

      HttpOverrides.global = null;
    });
    testWidgets('Show Selected Item Details', (WidgetTester tester) async {
      // arrange
      MockHomePageBloc homePageBloc = MockHomePageBloc();
      MockLocationBloc mockLocationBloc = MockLocationBloc();
      mockitail
          .when(() => homePageBloc.state)
          .thenReturn(BlocUtils.homePageSuccessState);
      mockitail
          .when(() => mockLocationBloc.state)
          .thenReturn(BlocUtils.kLocationSuccessState);

      await tester.pumpWidget(
        BlocProvider<LocationBloc>(
            create: (context) => mockLocationBloc,
            child: BlocProvider<HomePageBloc>(
                create: (context) => homePageBloc,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConst.kMaterialAppTitle,
                  theme: AppConst.getAppThem(),
                  home: HomePage(),
                ))),
      );

      expect(find.text('Munich'), findsOneWidget);
      expect(find.text(BlocUtils.homePageSuccessState.weatherItem.getTemp()),
          findsOneWidget);
      expect(
          find.text(
              'Humadity ${BlocUtils.homePageSuccessState.weatherItem.humidity?.round().toString()}%'),
          findsOneWidget);
    });

    testWidgets('show list of weather items', (WidgetTester tester) async {
      // arrange
      MockHomePageBloc homePageBloc = MockHomePageBloc();
      MockLocationBloc mockLocationBloc = MockLocationBloc();
      mockitail
          .when(() => homePageBloc.state)
          .thenReturn(BlocUtils.homePageSuccessState);
      mockitail
          .when(() => mockLocationBloc.state)
          .thenReturn(BlocUtils.kLocationSuccessState);

      await tester.pumpWidget(
        BlocProvider<LocationBloc>(
            create: (context) => mockLocationBloc,
            child: BlocProvider<HomePageBloc>(
                create: (context) => homePageBloc,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConst.kMaterialAppTitle,
                  theme: AppConst.getAppThem(),
                  home: HomePage(),
                ))),
      );

      expect(find.text('Munich'), findsOneWidget);
      expect(
          find.text(BlocUtils.homePageSuccessState.weatherList[1].getMaxTemp()),
          findsOneWidget);
      expect(
          find.text(BlocUtils.homePageSuccessState.weatherList[1].getMinTemp()),
          findsOneWidget);
    });
  });
}
