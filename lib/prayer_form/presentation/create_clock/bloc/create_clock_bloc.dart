import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_clock_use_case/create_clock_use_case.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_event.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_state.dart';

class CreateClockBloc extends Bloc<CreateClockEvent, CreateClockState> {
  CreateClockUseCase createClockUseCase;

  CreateClockBloc({
    required this.createClockUseCase,
  }) : super(CreationReadyState()) {
    on<RequestCreateClockEvent>(_onRequestCreateClockEvent);
    on<TryAgainEvent>(_onTryAgainEvent);
  }

  void _onRequestCreateClockEvent(RequestCreateClockEvent event, Emitter emit) async {
    emit(CreationLoadingState());
    try {
      await createClockUseCase.execute(event.request);
      emit(CreationSuccessState(event.request.code));
    } catch (e) {
      emit(CreationErrorState(e.toString()));
    }
  }

  void _onTryAgainEvent(TryAgainEvent event, Emitter emit) {
    emit(CreationReadyState());
  }
}
