import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_event.dart';

class NameScreen extends StatelessWidget {
  final _nameFieldController = TextEditingController();

  NameScreen({super.key});

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
            const Text("Digite seu nome:"),
            TextField(
              controller: _nameFieldController,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
                child: const Text("Avançar"),
                onPressed: () {
                  bloc.add(
                    NextOnNameScreen(name: _nameFieldController.text),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//TODO: Mover para arquivo proprio
class CustomCard extends StatelessWidget {
  final Widget? child;
  final double? height;

  const CustomCard({
    super.key,
    this.child,
    this.height = 248,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
        height: height,
        child: Padding(padding: const EdgeInsets.all(24.0), child: child),
      ),
    );
  }
}
