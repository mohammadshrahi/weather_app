import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/routes/routes.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/generated/codegen_loader.g.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  configureDependencies(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      assetLoader: CodegenLoader(),
      path: './assets/translations/',
      fallbackLocale: AppConst.kSupportedLocals.first,
      supportedLocales: AppConst.kSupportedLocals,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(value: getIt.get<LocationBloc>()),
          BlocProvider.value(value: getIt.get<HomePageBloc>()),
          BlocProvider.value(value: getIt.get<SettingsBloc>())
        ],
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: AppConst.kMaterialAppTitle,
            theme: AppConst.getAppThem(),
            home: HomePage(),
            routes: Routes.getRoutes()));
  }
}
