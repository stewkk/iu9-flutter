import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab1Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab2Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab2'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab3Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab6Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab6'),
            ),
          ],
        ),
      ),
    );
  }
}

class Lab1Screen extends StatefulWidget {
  const Lab1Screen({super.key});

  @override
  State<Lab1Screen> createState() => _Lab1ScreenState();
}

class _Lab1ScreenState extends State<Lab1Screen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Lab 1 - Counter App'),
      ),
      body: Center(
        
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class Lab2Screen extends StatelessWidget {
  const Lab2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Lab 2'),
      ),
      body: const Center(
        child: Text(
          'Lab 2 - TODO',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Lab3Screen extends StatelessWidget {
  const Lab3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Lab 3'),
      ),
      body: const Center(
        child: Text(
          'Lab 3 - TODO',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Lab6Screen extends StatefulWidget {
  const Lab6Screen({super.key});

  @override
  State<Lab6Screen> createState() => _Lab6ScreenState();
}

class _Lab6ScreenState extends State<Lab6Screen> {
  YandexMapController? _mapController;
  final MapObjectId _placemarkId = const MapObjectId('placemark');
  
  // Coordinates for Moscow, Russia
  static const Point _targetPoint = Point(latitude: 55.751225, longitude: 37.62954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Lab 6 - Yandex Maps'),
      ),
      body: YandexMap(
        onMapCreated: (YandexMapController controller) async {
          _mapController = controller;
          
          // Move camera to target point
          await _mapController?.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: _targetPoint,
                zoom: 15.0,
              ),
            ),
            animation: const MapAnimation(
              type: MapAnimationType.smooth,
              duration: 1.0,
            ),
          );
          
          // Add placemark
          await _addPlacemark();
        },
        mapObjects: [
          PlacemarkMapObject(
            mapId: _placemarkId,
            point: _targetPoint,
            opacity: 1.0,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('assets/icon.png'),
                scale: 0.5,
              ),
            ),
            onTap: (PlacemarkMapObject self, Point point) {
              _onPlacemarkTapped(point);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addPlacemark() async {
    // Placemark is already added in mapObjects
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Placemark added at Moscow coordinates'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _onPlacemarkTapped(Point point) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tapped placemark at: ${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
