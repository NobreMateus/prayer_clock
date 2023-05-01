abstract class CreateClockState {}

class CreationReadyState extends CreateClockState {}

class CreationLoadingState extends CreateClockState {}

class CreationErrorState extends CreateClockState {
  final String message;

  CreationErrorState(this.message);
}

class CreationSuccessState extends CreateClockState {
  String clockId;

  CreationSuccessState(this.clockId);
}
