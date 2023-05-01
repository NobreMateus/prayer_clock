import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_all_prayers_use_case/fetch_all_prayers_use_case.dart';

class FetchAllPrayersUseCaseImpl implements FetchAllPrayersUseCase {
  final PrayerClockRepository repository;

  FetchAllPrayersUseCaseImpl({
    required this.repository,
  });

  @override
  Future<List<Prayer>> execute(String clockId) async {
    return await repository.fetchAllPrayers(clockId);
  }
}
