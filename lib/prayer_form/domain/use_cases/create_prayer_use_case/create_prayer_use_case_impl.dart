import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_prayer_use_case/create_prayer_use_case.dart';

class CreatePrayerUseCaseImpl implements CreatePrayerUseCase {
  final PrayerClockRepository repository;

  CreatePrayerUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Prayer> execute(Prayer prayer) async {
    return await repository.createPrayer(prayer);
  }
}
