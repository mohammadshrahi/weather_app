import 'package:injectable/injectable.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/domain/entities/settings.dart';
import 'package:weather_app/domain/repositories/settings.dart';

@LazySingleton()
class GetSettings implements UseCase<Setting, void> {
  GetSettings(this.settingsRepository);
  SettingsRepository settingsRepository;
  @override
  Future<Setting> call({void params}) async {
    return await settingsRepository.getSettings();
  }
}
