import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prayer_clock/prayer_form/data/create_empty_prayer.dart';
import 'package:prayer_clock/prayer_form/data/empty_prayer.dart';
import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';
import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';
import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/domain/repositories/prayer_clock_repository.dart';

class FirestoreRepositoryImpl implements PrayerClockRepository {
  final _db = FirebaseFirestore.instance;
  final dayInMinutes = 1440;

  @override
  Future<Clock> createClock(NewClockRequest request) async {
    final doc = await _db.collection("pray-clocks").doc(request.code).get();
    if (doc.exists) {
      throw Exception('Identificador já em uso!');
    }
    if (dayInMinutes % request.interval != 0) {
      throw Exception('Intervalo inválido');
    }

    await _db.collection("pray-clocks").doc(request.code).set({
      'code': request.code,
      'title': request.title,
      'description': request.description,
      'interval': request.interval,
    });
    final createEmptyPrayer = CreateEmptyPrayer();
    final emptyPrayers = createEmptyPrayer.create(request);
    await _saveEmptyPreayers(emptyPrayers, request.code);
    await Future.delayed(const Duration(seconds: 3));
    return Clock(
      code: request.code,
      title: request.title,
      description: request.description,
    );
  }

  Future<void> _saveEmptyPreayers(List<EmptyPrayer> emptyPrayers, String clockId) async {
    final batch = _db.batch();
    for (final emptyPrayer in emptyPrayers) {
      final path = _db.collection('pray-clocks').doc(clockId).collection('prayers').doc(emptyPrayer.prayTime.hour);
      batch.set(
        path,
        {
          'hour': emptyPrayer.prayTime.hour,
          'isEmpty': true,
        },
      );
    }
    await batch.commit();
  }

  @override
  Future<Prayer> createPrayer(Prayer prayer) async {
    await _db.collection("pray-clocks").doc(prayer.clockId).collection('prayers').doc(prayer.prayTime.hour).set({
      'name': prayer.name,
      'email': prayer.email ?? '',
      'phone': prayer.phone ?? '',
      'clockId': prayer.clockId,
      'isEmpty': false,
    }, SetOptions(merge: true));
    return Prayer(
      clockId: prayer.clockId,
      name: prayer.name,
      prayTime: prayer.prayTime,
    );
  }

  @override
  Future<List<PrayTime>> fetchAvailablePrayTimes(String clockId) async {
    final prayersData =
        await _db.collection("pray-clocks").doc(clockId).collection('prayers').where('isEmpty', isEqualTo: true).get();
    final prayers = prayersData.docs.map((doc) => PrayTime(hour: doc['hour'] ?? '')).toList();
    return prayers;
  }

  @override
  Future<bool> clockExists(String clockId) async {
    final clock = await _db.collection('pray-clocks').doc(clockId).get();
    return clock.exists;
  }

  @override
  Future<List<Prayer>> fetchAllPrayers(String clockId) async {
    final col = await _db
        .collection('pray-clocks')
        .doc(clockId)
        .collection('prayers')
        .where(
          'isEmpty',
          isEqualTo: false,
        )
        .get();
    final prayers = col.docs.map((doc) {
      final data = doc.data();
      return Prayer(
        clockId: clockId,
        name: data['name'],
        prayTime: PrayTime(hour: data['hour']),
        email: data['email'],
        phone: data['phone'],
      );
    });
    return prayers.toList();
  }

  @override
  Future<Clock> fetchClock(String clockId) async {
    final doc = await _db.collection('pray-clocks').doc(clockId).get();
    final data = doc.data();
    return Clock(
      code: data?['code'] ?? '',
      title: data?['title'] ?? '',
      description: data?['description'] ?? '',
    );
  }
}
