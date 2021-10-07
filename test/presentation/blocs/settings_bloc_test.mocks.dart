// Mocks generated by Mockito 5.0.16 from annotations
// in weather_app/test/presentation/blocs/settings_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/domain/entities/settings.dart' as _i3;
import 'package:weather_app/domain/repositories/settings.dart' as _i2;
import 'package:weather_app/domain/usecases/settings/get_setting.dart' as _i4;
import 'package:weather_app/domain/usecases/settings/set_settings.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSettingsRepository_0 extends _i1.Fake
    implements _i2.SettingsRepository {}

class _FakeSetting_1 extends _i1.Fake implements _i3.Setting {}

/// A class which mocks [GetSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSettings extends _i1.Mock implements _i4.GetSettings {
  MockGetSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SettingsRepository get settingsRepository =>
      (super.noSuchMethod(Invocation.getter(#settingsRepository),
          returnValue: _FakeSettingsRepository_0()) as _i2.SettingsRepository);
  @override
  set settingsRepository(_i2.SettingsRepository? _settingsRepository) => super
      .noSuchMethod(Invocation.setter(#settingsRepository, _settingsRepository),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.Setting> call({void params}) =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue: Future<_i3.Setting>.value(_FakeSetting_1()))
          as _i5.Future<_i3.Setting>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SetSettings].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetSettings extends _i1.Mock implements _i6.SetSettings {
  MockSetSettings() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SettingsRepository get settingsRepository =>
      (super.noSuchMethod(Invocation.getter(#settingsRepository),
          returnValue: _FakeSettingsRepository_0()) as _i2.SettingsRepository);
  @override
  set settingsRepository(_i2.SettingsRepository? _settingsRepository) => super
      .noSuchMethod(Invocation.setter(#settingsRepository, _settingsRepository),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> call({_i3.Setting? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}