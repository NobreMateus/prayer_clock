import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/check_clock_existence_use_case/check_clock_existence_use_case.dart';

class CheckClockExistanceUseCaseImpl implements CheckClockExistanceUseCase {
  final PrayerClockRepository repository;

  CheckClockExistanceUseCaseImpl({required this.repository});

  @override
  Future<bool> execute(String clockId) async {
    return await repository.clockExists(clockId);
  }
}
