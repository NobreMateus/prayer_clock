import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';

abstract class FetchAllPrayersUseCase {
  Future<List<Prayer>> execute(String clockId);
}
