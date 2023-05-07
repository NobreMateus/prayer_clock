import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/entities/clock.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/name_screen/name_screen.dart';

class InformationScreen extends StatelessWidget {
  final Clock clock;

  const InformationScreen({
    Key? key,
    required this.clock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<PrayerFormBloc>();
    return Center(
      child: CustomCard(
        height: null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(clock.title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(clock.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 36,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
                onPressed: () {
                  bloc.add(NextOnShowInformations());
                },
                child: const Text("Avançar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
