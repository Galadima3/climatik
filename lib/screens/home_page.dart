// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:climatik/dataprovider/data_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue testData = ref.watch(locationWeatherProvider);
    //final AsyncValue<WeatherModel> user = ref.watch(locationWeatherProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                const Text(
                  'Climatik',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      ref.refresh(locationWeatherProvider);
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            Center(
              child: testData.when(
                  data: (_data) {
                    print(_data);
                    return Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          '${_data[0]}',
                          style: kCityStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: kDateStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${_data[1].toStringAsFixed(0)}°C',
                          style: kTempStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          capitalizeAllWord(_data[3]),
                          style: kWeatherData,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/overcast.jpeg'))
                          ),
                        )
                      ],
                    );
                  },
                  error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                  loading: () => const CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
