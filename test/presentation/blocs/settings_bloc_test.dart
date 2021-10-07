import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/model/settings.dart';
import 'package:weather_app/domain/entities/settings.dart';
import 'package:weather_app/domain/usecases/settings/get_setting.dart';
import 'package:weather_app/domain/usecases/settings/set_settings.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';

import 'settings_bloc_test.mocks.dart';

@GenerateMocks([GetSettings, SetSettings])
main() {
  group('SettingBlock', () {
    MockGetSettings getSettings = MockGetSettings();
    MockSetSettings setSettings = MockSetSettings();
    setUpAll(() {
      when(getSettings.call())
          .thenAnswer((_) => Future.value(SettingsItem(true)));
      // when(setSettings.call()).thenAnswer(Future<void>.value());
    });

    blocTest(
      'emits SuccessState when GetSettingsEvent added',
      build: () => SettingsBloc(getSettings, setSettings),
      act: (SettingsBloc? bloc) => bloc?.add(GetSettingsEvent()),
      expect: () => [SettingsSuccessState(SettingsItem(true))],
    );

    // blocTest(
    //   'emits [1] when Increment is added',
    //   build: () => CounterBloc(),
    //   act: (bloc) => bloc.add(Increment()),
    //   expect: () => [1],
    // );
  });
}
