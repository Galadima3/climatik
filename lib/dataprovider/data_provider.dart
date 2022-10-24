import 'package:climatik/services/networking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationWeatherProvider = FutureProvider((ref) => ref.watch(weatherProvider).getLocationWeather(),);