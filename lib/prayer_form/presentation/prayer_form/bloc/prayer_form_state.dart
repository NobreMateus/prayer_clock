import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';

abstract class PrayerFormState {}

class LoadingClockIdState extends PrayerFormState {}

class LoadingAvailablePrayTimes extends PrayerFormState {}

class LoadingCreationPrayer extends PrayerFormState {}

class ShowingInformations extends PrayerFormState {
  final Clock clock;

  ShowingInformations({
    required this.clock,
  });
}

class WritingNameState extends PrayerFormState {}

class WritingPhoneState extends PrayerFormState {}

class SelectingPrayerHourState extends PrayerFormState {
  final List<PrayTime> prayTimes;

  SelectingPrayerHourState({
    required this.prayTimes,
  });
}

class SuccessState extends PrayerFormState {}

class NoClockIdState extends PrayerFormState {}
