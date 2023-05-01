import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';

abstract class FetchAvailablePrayTimesUseCase {
  Future<List<PrayTime>> execute(String clockId);
}
