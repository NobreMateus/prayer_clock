import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/main.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/name_screen/name_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: CustomCard(
        child: Column(
          children: [
            const Spacer(),
            const Text("Obrigado! Lembre-se de orar constantemente"),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
                onPressed: () {
                  final clockId = BlocProvider.of<PrayerFormBloc>(context).clockId;
                  CustomRouter.router.navigateTo(context, '/clock-list/$clockId');
                },
                child: const Text('Ver Lista de Oradores'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
