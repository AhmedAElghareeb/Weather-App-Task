import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/weather_cubit.dart';
import '../widgets/weather_body.dart';

/// Entry point for the Weather Feature.
/// Sets up the BLoC provider to inject the [WeatherCubit] into the widget tree.
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Creates the Cubit and immediately triggers loading the last searched city
      // to ensure a seamless experience if the user has used the app before.
      create: (context) => WeatherCubit()..loadLastSearchedCity(),
      child: const WeatherBody(),
    );
  }
}
