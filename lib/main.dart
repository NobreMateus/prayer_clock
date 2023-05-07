import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:prayer_clock/firebase_options.dart';
import 'package:prayer_clock/prayer_form/data/firestore_repository_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/check_clock_existence_use_case/check_clock_existence_use_case_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_clock_use_case/create_clock_use_case_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/create_prayer_use_case/create_prayer_use_case_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_all_prayers_use_case/fetch_all_prayers_use_case_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_available_pray_times_use_case/fetch_available_pray_times_impl.dart';
import 'package:prayer_clock/prayer_form/domain/use_cases/fetch_clock_use_case/fetch_clock_use_case_impl.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/bloc/create_clock_bloc.dart';
import 'package:prayer_clock/prayer_form/presentation/create_clock/create_clock_screen.dart';
import 'package:prayer_clock/prayer_form/presentation/home_start/home_start.dart';
import 'package:prayer_clock/prayer_form/presentation/prayer_form/bloc/prayer_form_bloc.dart';
import 'prayer_form/presentation/clock_prayers_list/clock_prayers_list.dart';
import 'prayer_form/presentation/prayer_form/form_screen/form_screen.dart';

final themeData = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
    primaryColor: const Color.fromRGBO(27, 70, 129, 1));

void main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CustomRouter.configureRoutes();

  runApp(
    MaterialApp(
      theme: themeData,
      onGenerateRoute: CustomRouter.router.generator,
    ),
  );
}

class PrayerForm extends StatelessWidget {
  final repository = FirestoreRepositoryImpl();
  final String clockId;

  PrayerForm({
    super.key,
    required this.clockId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrayerFormBloc>(
      create: (context) => PrayerFormBloc(
        clockId: clockId,
        createPrayerUseCase: CreatePrayerUseCaseImpl(repository: repository),
        fetchAvailablePrayTimesUseCase: FetchAvailablePrayTimesUseCaseImpl(repository: repository),
        checkClockExistanceUseCase: CheckClockExistanceUseCaseImpl(repository: repository),
        fetchClockUseCase: FetchClockUseCaseImpl(repository: repository),
      ),
      child: const PrayFormScreen(),
    );
  }
}

//Fluro
class CustomRouter {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const Scaffold(
        body: Center(child: Text("Pagina inexistente")),
      );
    });
    router.define(
      '/',
      handler: Handler(
        handlerFunc: (context, params) => const HomeStart(),
      ),
    );
    router.define(
      'new-prayer/:clockId',
      handler: Handler(handlerFunc: (context, params) {
        final clockId = params['clockId']?.first;
        if (clockId == null) {
          return const Scaffold(
            body: Center(
              child: Text('Id do relógio Inválido'),
            ),
          );
        }
        return PrayerForm(clockId: clockId);
      }),
    );
    router.define('new-clock', handler: Handler(handlerFunc: (context, params) {
      return BlocProvider<CreateClockBloc>(
        create: (context) => CreateClockBloc(
          createClockUseCase: CreateClockUseCaseImpl(
            repository: FirestoreRepositoryImpl(),
          ),
        ),
        child: const CreateClockScreen(),
      );
    }));
    router.define(
      'clock-list/:clockId',
      handler: Handler(handlerFunc: (context, params) {
        final repository = FirestoreRepositoryImpl();
        final clockId = params['clockId']?.first;
        if (clockId == null) {
          return const Scaffold(
            body: Center(
              child: Text('Id do relógio Inválido'),
            ),
          );
        }
        return BlocProvider<ClockPrayersListCubit>(
          create: (context) => ClockPrayersListCubit(
            clockId: clockId,
            fetchAllPrayersUseCase: FetchAllPrayersUseCaseImpl(repository: repository),
          ),
          child: const ClockPrayersList(),
        );
      }),
    );
  }
}
