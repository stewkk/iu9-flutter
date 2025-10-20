import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class LocationData {
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  final String? tel;

  LocationData({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
    this.tel,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    double lat = 0.0;
    double lon = 0.0;
    
    if (json['gps'] != null) {
      final gpsString = json['gps'].toString();
      final parts = gpsString.split(',');
      if (parts.length == 2) {
        lat = double.tryParse(parts[0].trim()) ?? 0.0;
        lon = double.tryParse(parts[1].trim()) ?? 0.0;
      }
    } else {
      lat = (json['latitude'] ?? json['lat'] ?? 0.0).toDouble();
      lon = (json['longitude'] ?? json['lon'] ?? json['lng'] ?? 0.0).toDouble();
    }
    
    return LocationData(
      name: json['name'] ?? 'Unknown',
      latitude: lat,
      longitude: lon,
      address: json['address'],
      tel: json['tel'],
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
  List<LocationData> _locations = [];
  bool _isLoading = true;
  String? _errorMessage;
  
  static const String _jsonUrl = 'http://pstgu.yss.su/iu9/mobiledev/lab4_yandex_map/2023.php?x=var23';

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final response = await http.get(Uri.parse(_jsonUrl));
      
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<LocationData> locations = [];
        
        if (jsonData is List) {
          for (var item in jsonData) {
            if (item is Map<String, dynamic>) {
              locations.add(LocationData.fromJson(item));
            }
          }
        } else if (jsonData is Map<String, dynamic>) {
          if (jsonData.containsKey('locations')) {
            final locList = jsonData['locations'] as List;
            for (var item in locList) {
              if (item is Map<String, dynamic>) {
                locations.add(LocationData.fromJson(item));
              }
            }
          } else {
            locations.add(LocationData.fromJson(jsonData));
          }
        }
        
        setState(() {
          _locations = locations;
          _isLoading = false;
        });
        
        if (locations.isNotEmpty && _mapController != null) {
          await _mapController?.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: locations[0].latitude,
                  longitude: locations[0].longitude,
                ),
                zoom: 12.0,
              ),
            ),
            animation: const MapAnimation(
              type: MapAnimationType.smooth,
              duration: 1.0,
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load data: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching data: $e';
        _isLoading = false;
      });
    }
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
        title: const Text('Lab 6 - Yandex Maps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchLocations,
            tooltip: 'Refresh locations',
          ),
        ],
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController controller) async {
              _mapController = controller;
              
              if (_locations.isNotEmpty) {
                await _mapController?.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: _locations[0].latitude,
                        longitude: _locations[0].longitude,
                      ),
                      zoom: 12.0,
                    ),
                  ),
                  animation: const MapAnimation(
                    type: MapAnimationType.smooth,
                    duration: 1.0,
                  ),
                );
              }
            },
            mapObjects: _locations.map((location) {
              return PlacemarkMapObject(
                mapId: MapObjectId('placemark_${location.name}_${location.latitude}_${location.longitude}'),
                point: Point(
                  latitude: location.latitude,
                  longitude: location.longitude,
                ),
                opacity: 1.0,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/icon.png'),
                    scale: 0.3,
                  ),
                ),
                onTap: (PlacemarkMapObject self, Point point) {
                  _showLocationInfo(location);
                },
              );
            }).toList(),
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_errorMessage != null && !_isLoading)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showLocationInfo(LocationData location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(location.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (location.address != null) ...[
                  const Text(
                    'Address:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(location.address!),
                  const SizedBox(height: 12),
                ],
                if (location.tel != null) ...[
                  const Text(
                    'Telephone:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(location.tel!),
                  const SizedBox(height: 12),
                ],
                const Text(
                  'Coordinates:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lat: ${location.latitude.toStringAsFixed(6)}\n'
                  'Lon: ${location.longitude.toStringAsFixed(6)}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
