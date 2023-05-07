class NewClockRequest {
  String code;
  String title;
  String description;
  int interval;

  NewClockRequest({
    required this.code,
    required this.title,
    required this.description,
    required this.interval,
  });
}
