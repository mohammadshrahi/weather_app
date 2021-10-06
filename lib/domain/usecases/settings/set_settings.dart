import 'package:injectable/injectable.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/domain/entities/settings.dart';
import 'package:weather_app/domain/repositories/settings.dart';

@LazySingleton()
class SetSettings implements UseCase<void, Setting> {
  SetSettings(this.settingsRepository);
  SettingsRepository settingsRepository;
  @override
  Future<void> call({Setting? params}) async {
    await settingsRepository.setSettings(params!);
  }
}
