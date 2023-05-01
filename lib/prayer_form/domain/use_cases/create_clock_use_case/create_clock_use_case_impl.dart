import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';
import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_clock_use_case/create_clock_use_case.dart';

class CreateClockUseCaseImpl implements CreateClockUseCase {
  final PrayerClockRepository repository;

  CreateClockUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Clock> execute(NewClockRequest request) async {
    return await repository.createClock(request);
  }
}
