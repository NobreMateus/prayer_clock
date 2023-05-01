import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_state.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/name_screen/name_screen.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/phone_screen/phone_screen.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/pray_time_select_screen/pray_time_select_screen.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/success_screen/success_screen.dart';

class PrayFormScreen extends StatelessWidget {
  const PrayFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PrayerFormBloc>(context);
    bloc.add(IsReadyEvent());
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<PrayerFormBloc, PrayerFormState>(
              builder: (context, state) {
                if (state is LoadingClockIdState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is WritingNameState) {
                  return NameScreen();
                }
                if (state is WritingPhoneState) {
                  return PhoneScreen();
                }
                if (state is LoadingAvailablePrayTimes) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SelectingPrayerHourState) {
                  return PrayTimeSelectScreen(prayTimes: state.prayTimes);
                }
                if (state is LoadingCreationPrayer) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SuccessState) {
                  return const SuccessScreen();
                }
                if (state is NoClockIdState) {
                  return const Center(child: Text("Relógio não encontrado"));
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
