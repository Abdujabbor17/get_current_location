import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Initialize variable
  Position? position;
  bool? isLoaded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoLocator'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoaded = true;
                });
                //request permission
                await Geolocator.requestPermission();
                Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high)
                    .then((value) {
                  position = value;
                  print('==========================');
                  print('Latitude: ${position?.latitude ?? '-----------'}');
                  print('Longitude: ${position?.longitude ?? '---------------'}');
                  print('==========================');
                  isLoaded = false;
                  setState(() {});
                });

              },
              child: const Text('Get Current Location'),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoaded ?? false
                ? const CircularProgressIndicator()
                : const SizedBox(height: 50),
            Text('Latitude: ${position?.latitude ?? '???????'}'),
            const SizedBox(
              height: 16,
            ),
            Text('Longitude: ${position?.longitude ?? '????????'}'),
          ],
        ),
      ),
    );
  }
}
