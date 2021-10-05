import 'dart:io';

import 'package:weather_app/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('gifs assets test', () {
    expect(true, File(Gifs.snowing).existsSync());
    expect(true, File(Gifs.clouds).existsSync());
    expect(true, File(Gifs.raining).existsSync());
    expect(true, File(Gifs.cloudBlueG).existsSync());
  });
}
