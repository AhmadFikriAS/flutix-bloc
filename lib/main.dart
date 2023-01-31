import 'package:bwa_flutix/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      initialData: null,
      child: MultiBlocProvider(
          providers: [
            BlocProvider<PageBloc>(create: (ctx) => PageBloc()),
            BlocProvider<UserBloc>(create: (ctx) => UserBloc()),
            BlocProvider<ThemeBloc>(create: (ctx) => ThemeBloc()),
            BlocProvider<MovieBloc>(
              create: (ctx) => MovieBloc()..add(FetchMovies()),
            ),
            BlocProvider<TicketBloc>(create: (ctx) => TicketBloc())
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (ctx, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: const Wrapper()))),
    );
  }
}
