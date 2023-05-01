import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';

class Prayer {
  String clockId;
  String name;
  PrayTime prayTime;
  String? email;
  String? phone;

  Prayer({
    required this.clockId,
    required this.name,
    required this.prayTime,
    this.email,
    this.phone,
  });
}
