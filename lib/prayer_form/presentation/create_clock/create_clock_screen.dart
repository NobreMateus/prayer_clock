import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_event.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_state.dart';

class CreateClockScreen extends StatelessWidget {
  const CreateClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateClockBloc, CreateClockState>(builder: (context, state) {
        if (state is CreationReadyState) {
          return NewClockForm();
        }
        if (state is CreationLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CreationErrorState) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('Erro ao criar Relógio de Oração: ${state.message}')),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CreateClockBloc>(context).add(TryAgainEvent());
                    },
                    child: const Text("Tentar Novamente")),
              ],
            ),
          );
        }
        if (state is CreationSuccessState) {
          return Center(
              child: Column(
            children: [
              const Text('Relógio criado com Sucesso!'),
              const SizedBox(height: 24),
              const Text('Link para adicionar novo orador:'),
              SelectableText('${Uri.base.toString().replaceAll('/new-clock', '')}/new-prayer/${state.clockId}'),
            ],
          ));
        }
        return Container();
      }),
    );
  }
}

class NewClockForm extends StatelessWidget {
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _intervalController = TextEditingController();

  NewClockForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Identificador Único'),
          TextField(controller: _idController),
          const SizedBox(height: 12),
          const Text('Titulo do Relogio'),
          TextField(controller: _titleController),
          const SizedBox(height: 12),
          const Text('Intervalo do Relogio'),
          TextField(controller: _intervalController),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.primaryColor)),
              onPressed: () {
                BlocProvider.of<CreateClockBloc>(context).add(
                  RequestCreateClockEvent(
                    NewClockRequest(
                      code: _idController.text,
                      title: _titleController.text,
                      interval: int.tryParse(_intervalController.text) ?? 15,
                    ),
                  ),
                );
              },
              child: const Text("Criar"),
            ),
          ),
        ],
      ),
    );
  }
}
