import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_clock_use_case/fetch_clock_use_case.dart';

class FetchClockUseCaseImpl implements FetchClockUseCase {
  final PrayerClockRepository repository;

  FetchClockUseCaseImpl({required this.repository});

  @override
  Future<Clock> execute(String clockId) async {
    return await repository.fetchClock(clockId);
  }
}
