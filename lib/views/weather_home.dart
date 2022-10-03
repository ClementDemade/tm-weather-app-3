import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/views/day_detail_widget.dart';
import 'package:weather_app_3/views/day_weather_widget.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(),
        ),
      ],
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(child: _buildBody(context, state)),
            backgroundColor: Colors.white,
            persistentFooterButtons: [
              TextButton(
                onPressed: () {
                  BlocProvider.of<WeatherCubit>(context).refresh();
                },
                child: const Center(child: Text("Refresh")),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Météo'),
    );
  }

  Widget _buildBody(BuildContext context, WeatherState state) {
    if (state is WeatherLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is WeatherLoadedState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: state.weatherData.daily.time.length,
                itemBuilder: (context, index) => DayWeatherWidget(
                  weatherDay: state.weatherData.daily.getDay(index: index),
                ),
              ),
            ),
            const Divider(),
            const Text("Afficher le détail du jour ici"),
          ],
        ),
      );
    } else {
      return Center(
        child: ElevatedButton(
          onPressed: () => BlocProvider.of<WeatherCubit>(context).refresh(),
          child: const Text("Charger la météo"),
        ),
      );
    }
  }
}
