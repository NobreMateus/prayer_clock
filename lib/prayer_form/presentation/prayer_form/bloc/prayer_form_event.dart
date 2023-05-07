import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';

abstract class PrayerFormEvent {}

class NextOnShowInformations extends PrayerFormEvent {}

class NextOnNameScreen extends PrayerFormEvent {
  String name;

  NextOnNameScreen({
    required this.name,
  });
}

class NextOnPhoneScreen extends PrayerFormEvent {
  String phone;

  NextOnPhoneScreen({
    required this.phone,
  });
}

class NextOnPrayTimeScreen extends PrayerFormEvent {
  PrayTime selectedPrayTime;

  NextOnPrayTimeScreen({
    required this.selectedPrayTime,
  });
}

class IsReadyEvent extends PrayerFormEvent {}
