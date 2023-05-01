import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/entities/pray_time.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';

class PrayTimeSelectScreen extends StatelessWidget {
  final List<PrayTime> prayTimes;
  const PrayTimeSelectScreen({
    super.key,
    required this.prayTimes,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PrayerFormBloc>();
    return Column(
      children: [
        const SizedBox(height: 24),
        const Text(
          "Escolha o horário que deseja orar:",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: ListView.separated(
            itemCount: prayTimes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: ((context, index) {
              return PrayTimeSelector(
                prayHour: prayTimes[index].hour,
                onTap: () {
                  bloc.add(
                    NextOnPrayTimeScreen(selectedPrayTime: prayTimes[index]),
                  );
                },
              );
            }),
          ),
        )
      ],
    );
  }
}

class PrayTimeSelector extends StatefulWidget {
  final String prayHour;
  final void Function() onTap;

  const PrayTimeSelector({
    super.key,
    required this.prayHour,
    required this.onTap,
  });

  @override
  State<PrayTimeSelector> createState() => _PrayTimeSelectorState();
}

class _PrayTimeSelectorState extends State<PrayTimeSelector> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: () {
        setState(() {
          _isSelected = false;
        });
      },
      onTapDown: (_) {
        setState(() {
          _isSelected = true;
        });
      },
      onTapUp: (_) {
        widget.onTap();
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isSelected ? theme.primaryColor : Colors.white,
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            widget.prayHour,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isSelected ? theme.primaryColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
