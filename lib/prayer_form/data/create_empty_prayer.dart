import 'package:prayer_clock/prayer_form/data/empty_prayer.dart';
import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';
import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';

class CreateEmptyPrayer {
  final dayInMinutes = 1440;

  List<EmptyPrayer> create(NewClockRequest clockRequest) {
    List<EmptyPrayer> emptyPrayers = [];
    final prayersAmount = dayInMinutes / clockRequest.interval;
    for (int index = 0; index < prayersAmount; index++) {
      final hourInnMinutes = index * clockRequest.interval;
      final hour = (hourInnMinutes / 60).floorToDouble();
      final minutes = hourInnMinutes % 60;
      emptyPrayers.add(
        EmptyPrayer(
          prayTime: PrayTime(
            hour: '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}',
          ),
        ),
      );
    }
    return emptyPrayers;
  }
}
