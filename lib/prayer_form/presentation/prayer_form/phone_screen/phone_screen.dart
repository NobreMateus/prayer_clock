import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/name_screen/name_screen.dart';

class PhoneScreen extends StatelessWidget {
  final _phoneFieldController = TextEditingController();

  PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<PrayerFormBloc>();
    return Center(
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Digite seu telefone:"),
            TextField(
              controller: _phoneFieldController,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 36,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
                onPressed: () {
                  bloc.add(NextOnPhoneScreen(phone: _phoneFieldController.text));
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
