import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';
import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';

abstract class PrayerClockRepository {
  Future<Clock> createClock(NewClockRequest request);
  Future<Prayer> createPrayer(Prayer prayer);
  Future<List<PrayTime>> fetchAvailablePrayTimes(String clockId);
  Future<bool> clockExists(String clockId);
  Future<List<Prayer>> fetchAllPrayers(String clockId);
}
