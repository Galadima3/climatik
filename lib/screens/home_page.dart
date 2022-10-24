import 'dart:developer';

import 'package:climatik/dataprovider/data_provider.dart';
import 'package:climatik/models/weather_model.dart';
import 'package:climatik/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue testData = ref.watch(locationWeatherProvider);
    //final AsyncValue<WeatherModel> user = ref.watch(locationWeatherProvider);
    print(testData.hasValue);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                const Text('Climatik'),
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
                    List vex = _data;
                    print(vex[0]);
                    
                    print(_data);
                    return Column(
                      children: [
                        Text('City: ${_data[0]}'),
                        Text('${'Temp: '+_data[1].toStringAsFixed(0)}°C'),
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


// return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _data.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(_data[index].toString()),
//                         );
//                       },
//                     );