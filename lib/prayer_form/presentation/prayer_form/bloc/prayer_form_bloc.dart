import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/check_clock_existence_use_case/check_clock_existence_use_case.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_prayer_use_case/create_prayer_use_case.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_available_pray_times_use_case/fetch_available_pray_times.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_clock_use_case/fetch_clock_use_case.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_state.dart';

class PrayerFormBloc extends Bloc<PrayerFormEvent, PrayerFormState> {
  final CreatePrayerUseCase createPrayerUseCase;
  final FetchAvailablePrayTimesUseCase fetchAvailablePrayTimesUseCase;
  final CheckClockExistanceUseCase checkClockExistanceUseCase;
  final FetchClockUseCase fetchClockUseCase;
  final String clockId;
  String? _name;
  String? _phone;

  PrayerFormBloc({
    required this.clockId,
    required this.createPrayerUseCase,
    required this.fetchAvailablePrayTimesUseCase,
    required this.checkClockExistanceUseCase,
    required this.fetchClockUseCase,
  }) : super(LoadingClockIdState()) {
    on<NextOnShowInformations>(_onNextOnShowInformations);
    on<NextOnNameScreen>(_onNextOnNameScreen);
    on<NextOnPhoneScreen>(_onNextOnPhoneScreen);
    on<NextOnPrayTimeScreen>(_onNextOnPrayTimeScreen);
    on<IsReadyEvent>(_onIsReadyEvent);
  }

  _onNextOnShowInformations(NextOnShowInformations event, Emitter emit) {
    emit(WritingNameState());
  }

  _onIsReadyEvent(IsReadyEvent event, Emitter emit) async {
    final clockExists = await checkClockExistanceUseCase.execute(clockId);
    if (!clockExists) {
      emit(NoClockIdState());
      return;
    }
    final clock = await fetchClockUseCase.execute(clockId);
    emit(ShowingInformations(clock: clock));
  }

  _onNextOnNameScreen(NextOnNameScreen event, Emitter emit) {
    if (event.name.length <= 3) return;
    _name = event.name;
    emit(WritingPhoneState());
  }

  _onNextOnPhoneScreen(NextOnPhoneScreen event, Emitter emit) async {
    _phone = event.phone;
    emit(LoadingAvailablePrayTimes());
    final prayTimes = await fetchAvailablePrayTimesUseCase.execute(clockId);
    emit(SelectingPrayerHourState(prayTimes: prayTimes));
  }

  _onNextOnPrayTimeScreen(NextOnPrayTimeScreen event, Emitter emit) async {
    final prayer = Prayer(
      clockId: clockId,
      email: "",
      name: _name ?? "",
      phone: _phone ?? "",
      prayTime: event.selectedPrayTime,
    );
    emit(LoadingCreationPrayer());
    await createPrayerUseCase.execute(prayer);
    emit(SuccessState());
  }
}
