import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';

abstract class CreateClockUseCase {
  Future<Clock> execute(NewClockRequest request);
}
