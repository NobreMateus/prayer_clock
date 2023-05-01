import 'package:prayer_clock/prayer_form/domain/entities/requests/new_clock_request.dart';

abstract class CreateClockEvent {}

class RequestCreateClockEvent extends CreateClockEvent {
  final NewClockRequest request;

  RequestCreateClockEvent(this.request);
}

class TryAgainEvent extends CreateClockEvent {}
