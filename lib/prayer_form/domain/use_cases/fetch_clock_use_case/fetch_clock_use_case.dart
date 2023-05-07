import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';

abstract class FetchClockUseCase {
  Future<Clock> execute(String clockId);
}
