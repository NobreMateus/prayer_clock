import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';

abstract class CreatePrayerUseCase {
  Future<Prayer> execute(Prayer prayer);
}
