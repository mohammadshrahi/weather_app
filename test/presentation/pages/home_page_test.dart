import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart' as mockitail;
import 'package:weather_app/core/routes/routes.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/generated/codegen_loader.g.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import '../../utils/bloc_utils.dart';
import '../../utils/blocs/blocs.dart';
import 'package:weather_app/domain/entities/weather_item.dart';

void main() async {
  group('Home page', () {
    setUpAll(() {
      mockitail.registerFallbackValue<LocationState>(
          BlocUtils.kLocationSuccessState);
      mockitail
          .registerFallbackValue<HomePageState>(BlocUtils.homePageSuccessState);
      mockitail.registerFallbackValue<HomePageEvent>(HomePageWeatherGet(123));
      mockitail.registerFallbackValue<LocationEvent>(LocationGetEvent());
      mockitail
          .registerFallbackValue<SettingsState>(BlocUtils.settingsSuccessState);
      mockitail.registerFallbackValue<SettingsEvent>(GetSettingsEvent());
      HttpOverrides.global = null;
    });
    testWidgets('Show Selected Item Details', (WidgetTester tester) async {
      // arrange
      MockHomePageBloc homePageBloc = MockHomePageBloc();
      MockLocationBloc mockLocationBloc = MockLocationBloc();
      MockSettingsBloc mockSettingsBloc = MockSettingsBloc();
      mockitail
          .when(() => homePageBloc.state)
          .thenReturn(BlocUtils.homePageSuccessState);
      mockitail
          .when(() => mockLocationBloc.state)
          .thenReturn(BlocUtils.kLocationSuccessState);
      mockitail
          .when(() => mockSettingsBloc.state)
          .thenReturn(BlocUtils.settingsSuccessState);
      await tester.pumpWidget(LocalizedApp(
          BlocApp(homePageBloc, mockLocationBloc, mockSettingsBloc)));
      await Future.delayed(const Duration(milliseconds: 150), () {});
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
      MockSettingsBloc mockSettingsBloc = MockSettingsBloc();

      mockitail
          .when(() => homePageBloc.state)
          .thenReturn(BlocUtils.homePageSuccessState);
      mockitail
          .when(() => mockLocationBloc.state)
          .thenReturn(BlocUtils.kLocationSuccessState);
      mockitail
          .when(() => mockSettingsBloc.state)
          .thenReturn(BlocUtils.settingsSuccessState);
      await tester.pumpWidget(LocalizedApp(
          BlocApp(homePageBloc, mockLocationBloc, mockSettingsBloc)));

      await Future.delayed(const Duration(milliseconds: 150), () {});

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

class LocalizedApp extends StatelessWidget {
  LocalizedApp(this.blocApp, {Key? key}) : super(key: key);
  BlocApp blocApp;
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        assetLoader: CodegenLoader(),
        path: './assets/translations/',
        fallbackLocale: AppConst.kSupportedLocals.first,
        supportedLocales: AppConst.kSupportedLocals,
        child: blocApp);
  }
}

class BlocApp extends StatelessWidget {
  BlocApp(this.mockHomePageBloc, this.mockLocationBloc, this.mockSettingsBloc,
      {Key? key})
      : super(key: key);
  MockLocationBloc mockLocationBloc;
  MockHomePageBloc mockHomePageBloc;
  MockSettingsBloc mockSettingsBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
        create: (context) => mockSettingsBloc,
        child: BlocProvider<LocationBloc>(
            create: (context) => mockLocationBloc,
            child: BlocProvider<HomePageBloc>(
                create: (context) => mockHomePageBloc,
                child: MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    locale: context.locale,
                    supportedLocales: context.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    title: AppConst.kMaterialAppTitle,
                    theme: AppConst.getAppThem(),
                    home: HomePage(),
                    routes: Routes.getRoutes()))));
  }
}
