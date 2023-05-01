import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_clock/prayer_form/domain/entities/prayer.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_all_prayers_use_case/fetch_all_prayers_use_case.dart';

abstract class ClockPrayersListState {}

class ClockPrayersLoadingListState extends ClockPrayersListState {}

class ClockPrayersShowingPrayersState extends ClockPrayersListState {
  final List<Prayer> prayers;

  ClockPrayersShowingPrayersState(this.prayers);
}

class ClockPrayersListCubit extends Cubit<ClockPrayersListState> {
  FetchAllPrayersUseCase fetchAllPrayersUseCase;
  String clockId;

  ClockPrayersListCubit({
    required this.clockId,
    required this.fetchAllPrayersUseCase,
  }) : super(ClockPrayersLoadingListState()) {
    _loading();
  }

  _loading() async {
    final prayers = await fetchAllPrayersUseCase.execute(clockId);
    emit(ClockPrayersShowingPrayersState(prayers));
  }
}

class ClockPrayersList extends StatelessWidget {
  const ClockPrayersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ClockPrayersListCubit, ClockPrayersListState>(
          builder: (context, state) {
            if (state is ClockPrayersLoadingListState) {
              const Center(child: CircularProgressIndicator());
            }
            if (state is ClockPrayersShowingPrayersState) {
              return ListView.separated(
                  itemCount: state.prayers.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (contexte, index) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Expanded(
                          child: Row(
                            children: [
                              Text(
                                state.prayers[index].prayTime.hour,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(state.prayers[index].name),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
