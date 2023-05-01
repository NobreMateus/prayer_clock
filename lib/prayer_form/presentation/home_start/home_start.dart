import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:prayer_clock/main.dart';

class HomeStart extends StatelessWidget {
  const HomeStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            _NewPrayCard(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _NewPrayCard extends StatelessWidget {
  final _identifierController = TextEditingController();

  _NewPrayCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: 300,
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const Spacer(),
              const Text(
                'Relógio de Oração',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                  textAlign: TextAlign.center,
                  'Digite o identificador único do seu relógio de oração. Depois preencha suas informações e selecione o horário que prefere orar!'),
              TextField(
                controller: _identifierController,
                decoration: const InputDecoration(hintText: 'Identificador do relógio'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
                  onPressed: () {
                    if (_identifierController.text.isNotEmpty) {
                      CustomRouter.router.navigateTo(
                        context,
                        'new-prayer/${_identifierController.text}',
                        transition: TransitionType.fadeIn,
                      );
                    }
                  },
                  child: const Text('Nova Oração'),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  const Spacer(),
                  const Text('Deseja criar um novo relógio? '),
                  MouseRegion(
                    child: GestureDetector(
                      onTap: () {
                        CustomRouter.router.navigateTo(context, "new-clock", transition: TransitionType.fadeIn);
                      },
                      child: Text(
                        'Clique aqui!',
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ]),
          ),
        ));
  }
}
