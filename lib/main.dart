import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';

import 'data/data/model/lat_long.dart';
import 'data/data/local_db/local_db.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await LatLong_db().addMovement(MovementModel(
        lat: position.latitude,
        long: position.longitude,
        time: DateTime.now().toString()));
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask("task-identifier", "simpleTask",
      frequency: const Duration(minutes: 15));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MovementInfoPage());
  }
}

class MovementInfoPage extends StatelessWidget {
  const MovementInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lat Long"),
        actions: [
          IconButton(
            onPressed: () async {
              await Geolocator.requestPermission();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: LatLong_db().getMovements(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MovementModel> movements = snapshot.data!;

            return ListView.builder(
                itemCount: movements.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(movements[index].long.toString()),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
