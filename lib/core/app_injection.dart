import 'package:get_it/get_it.dart';
import 'package:notify/core/injections/auth_injection.dart';
import 'package:notify/core/injections/channel_manipolation_injection.dart';
import 'package:notify/core/injections/core_injection.dart';
import 'package:notify/core/injections/diaplay_channel_injection.dart';
import 'package:notify/core/injections/home_injection.dart';
import 'package:notify/core/injections/image_util_injection.dart';
import 'package:notify/core/injections/search_injection.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await saveLocalDataInjection();
  await networkInjections();
  await authinjections();
  await searchBlocInjections();
  await imageUtilInjections();
  await channelFeatureInjection();
  await displaychannelFeatureInjection();
  await homeScreenBlocInjections();
  await getChannelDataInjection();
  await getUserDataInjection();
}
