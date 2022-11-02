// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:climatik/dataprovider/data_provider.dart';
import 'package:climatik/screens/search_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue testData = ref.watch(locationWeatherProvider);
    //final AsyncValue<WeatherModel> user = ref.watch(locationWeatherProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Climatik'),
          centerTitle: true,
          toolbarHeight: 50,
          actions: [
            IconButton(
                onPressed: () {
                  ref.refresh(locationWeatherProvider);
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'TransitTag',
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    pageBuilder: (_, __, ___) => ScreenPage()));
          },
          child: const Icon(Icons.search),
        ),
        body: Column(
          children: [
            Center(
              child: testData.when(
                  data: (_data) {
                    print(_data);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 345,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 8, 0, 10),
                                  child: Icon(Icons.location_pin),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  '${_data[0]}',
                                  style: kCityStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.calendar_month),
                                Text(
                                  DateFormat.yMMMMEEEEd()
                                      .format(DateTime.now()),
                                  style: kDateStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 8, 0, 0),
                                  child: Icon(Icons.trending_up),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  '${_data[1].toStringAsFixed(0)}°C',
                                  style: kTempStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 8, 0, 10),
                                  child: Icon(Icons.cloud),
                                ),
                                const SizedBox(width: 70),
                                Text(
                                  capitalizeAllWord(_data[3]),
                                  style: kWeatherData,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator())),
            )
          ],
        ),
      ),
    );
  }
}
