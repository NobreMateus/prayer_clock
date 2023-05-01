import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_available_pray_times_use_case/fetch_available_pray_times.dart';

class FetchAvailablePrayTimesUseCaseImpl implements FetchAvailablePrayTimesUseCase {
  final PrayerClockRepository repository;

  FetchAvailablePrayTimesUseCaseImpl({
    required this.repository,
  });

  @override
  Future<List<PrayTime>> execute(String clockId) async {
    return await repository.fetchAvailablePrayTimes(clockId);
  }
}
