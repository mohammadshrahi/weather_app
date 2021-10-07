import 'package:bloc_test/bloc_test.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockHomePageBloc extends MockBloc<HomePageEvent, HomePageState>
    implements HomePageBloc {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}
