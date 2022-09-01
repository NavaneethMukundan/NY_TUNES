import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ny_tunes/database/Playlist_Model/playlist_model.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/widgets/playlist_db.dart';
import 'package:ny_tunes/state_managment/provider/state_navigation.dart';
import 'package:ny_tunes/widgets/others/splash.dart';
import 'package:provider/provider.dart';

import 'state_managment/provider/main_functions/main_functions.dart';
import 'state_managment/provider/main_functions/widgets/favorite_db_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
  }
  await Hive.openBox<int>('favoriteDB');
  await Hive.openBox<MusicModel>('playlist');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeFunctionController()),
            ChangeNotifierProvider(create: (_) => SearchFunctionController()),
            ChangeNotifierProvider(create: (_) => FavoriteFunctionController()),
            ChangeNotifierProvider(create: (_) => PlaylistDatabase()),
            ChangeNotifierProvider(create: (_) => PlaylistFunctionController()),
            ChangeNotifierProvider(create: (_) => NavigationFunctionControl()),
            ChangeNotifierProvider(create: (_) => MiniPlayer()),
            ChangeNotifierProvider(create: (_) => PlayerFunctionController())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NY Tunes',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          ),
        ));
  }
}
