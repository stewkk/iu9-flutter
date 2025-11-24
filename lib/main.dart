import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:convert' as convert;

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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab8Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab 8'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Lab9Screen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('lab 9'),
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
        
        for (var item in jsonData) {
          if (item is Map<String, dynamic>) {
            locations.add(LocationData.fromJson(item));
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

class Lab8Screen extends StatefulWidget {
  const Lab8Screen({super.key});

  @override
  State<Lab8Screen> createState() => _Lab8ScreenState();
}

class _Lab8ScreenState extends State<Lab8Screen> {
  final TextEditingController _hostController = TextEditingController(text: 'students.yss.su');
  final TextEditingController _usernameController = TextEditingController(text: 'ftpiu8');
  final TextEditingController _passwordController = TextEditingController(text: '3Ru7yOTA');
  final TextEditingController _directoryController = TextEditingController(text: '/');
  
  FTPConnect? _ftpConnect;
  bool _isConnected = false;
  bool _isConnecting = false;
  List<FTPEntry> _files = [];
  bool _isLoadingFiles = false;
  String _statusMessage = '';

  @override
  void dispose() {
    _hostController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _directoryController.dispose();
    _disconnect();
    super.dispose();
  }

  Future<void> _connect() async {
    if (_hostController.text.isEmpty) {
      _showMessage('Please enter a host');
      return;
    }

    setState(() {
      _isConnecting = true;
      _statusMessage = 'Connecting...';
    });

    try {
      _ftpConnect = FTPConnect(
        _hostController.text,
        user: _usernameController.text.isEmpty ? 'anonymous' : _usernameController.text,
        pass: _passwordController.text,
        timeout: 30,
      );
      
      _ftpConnect!.supportIPV6 = true;
      
      await _ftpConnect!.connect();
      
      setState(() {
        _isConnected = true;
        _isConnecting = false;
        _statusMessage = 'Connected successfully';
      });
      
      await _loadFileList();
    } catch (e) {
      setState(() {
        _isConnected = false;
        _isConnecting = false;
        _statusMessage = 'Connection failed: $e';
      });
      _showMessage('Connection failed: $e');
    }
  }

  Future<void> _disconnect() async {
    if (_ftpConnect != null) {
      try {
        await _ftpConnect!.disconnect();
      } catch (e) {
      }
      setState(() {
        _isConnected = false;
        _files = [];
        _statusMessage = 'Disconnected';
      });
    }
  }

  Future<void> _loadFileList() async {
    if (!_isConnected || _ftpConnect == null) return;

    setState(() {
      _isLoadingFiles = true;
      _statusMessage = 'Loading file list...';
    });

    try {
      
      if (_directoryController.text.isNotEmpty) {
        await _ftpConnect!.changeDirectory(_directoryController.text);
      }
      
      final fileList = await _ftpConnect!.listDirectoryContent();
      setState(() {
        _files = fileList;
        _isLoadingFiles = false;
        _statusMessage = 'Files loaded';
      });
    } catch (e) {
      setState(() {
        _isLoadingFiles = false;
        _statusMessage = 'Failed to load files: $e';
      });
      _showMessage('Failed to load files: $e');
    }
  }

  Future<void> _downloadFile(FTPEntry file) async {
    if (!_isConnected || _ftpConnect == null) return;

    try {
      _showMessage('Downloading ${file.name}...');
      
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      
      final localFile = File('${directory.path}/${file.name}');
      
      final success = await _ftpConnect!.downloadFileWithRetry(
        file.name,
        localFile,
        pRetryCount: 2,
      );
      
      if (!success) {
        _showMessage('Download failed');
      }
    } catch (e) {
      _showMessage('Download error: $e');
    }
  }

  Future<void> _uploadFile() async {
    if (!_isConnected || _ftpConnect == null) {
      _showMessage('Not connected to server');
      return;
    }

    try {
      final result = await FilePicker.platform.pickFiles();
      
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        
        _showMessage('Uploading ${result.files.single.name}...');
        
        if (_directoryController.text.isNotEmpty) {
          await _ftpConnect!.changeDirectory(_directoryController.text);
        }
        
        final success = await _ftpConnect!.uploadFileWithRetry(
          file,
          pRetryCount: 2,
        );
        
        if (success) {
          _showMessage('Uploaded successfully');
          await _loadFileList();
        } else {
          _showMessage('Upload failed');
        }
      }
    } catch (e) {
      _showMessage('Upload error: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lab 8 - FTP Client'),
        actions: [
          if (_isConnected)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadFileList,
              tooltip: 'Refresh',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_isConnected) ...[
              TextField(
                controller: _hostController,
                decoration: const InputDecoration(
                  labelText: 'Host',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isConnecting,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isConnecting,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                enabled: !_isConnecting,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isConnecting ? null : _connect,
                label: Text(_isConnecting ? 'Connecting...' : 'Connect'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
            if (_isConnected) ...[
              Card(
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _disconnect,
                          label: const Text('Disconnect'),
                        ),
                      ],
                   ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _directoryController,
                  decoration: const InputDecoration(
                    labelText: 'Directory',
                    border: OutlineInputBorder(),
                    hintText: '/ or /upload',
                  ),
                  onSubmitted: (_) => _loadFileList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _statusMessage,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _uploadFile,
                      label: const Text('Upload File'),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Files on Server:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _isLoadingFiles
                    ? const Center(child: CircularProgressIndicator())
                    : _files.where((file) => file.type != FTPEntryType.dir).isEmpty
                        ? const Center(
                            child: Text(
                              'No files found',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _files.where((file) => file.type != FTPEntryType.dir).length,
                            itemBuilder: (context, index) {
                              final filesOnly = _files.where((file) => file.type != FTPEntryType.dir).toList();
                              final file = filesOnly[index];
                              
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_drive_file,
                                  ),
                                  title: Text(file.name),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: () => _downloadFile(file),
                                    tooltip: 'Download',
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

class EmailContact {
  final String name;
  final String email;

  EmailContact({required this.name, required this.email});
}

class Lab9Screen extends StatefulWidget {
  const Lab9Screen({super.key});

  @override
  State<Lab9Screen> createState() => _Lab9ScreenState();
}

class _Lab9ScreenState extends State<Lab9Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _smtpHostController = TextEditingController(text: 'smtp.mail.ru');
  final TextEditingController _smtpPortController = TextEditingController(text: '587');
  final TextEditingController _senderEmailController = TextEditingController(text: 'rasteny@dvasharika.posevin.ru');
  final TextEditingController _senderPasswordController = TextEditingController(text: 'jpr31Qzmr3W8A0XklOZO');
  final TextEditingController _subjectController = TextEditingController(text: 'Hello, [Имя]');
  final TextEditingController _messageController = TextEditingController(text: 'Привет [Имя]!\n\nЯ моп и я люблю Яндекс! Я моп и я люблю Яндекс! Я моп и я люблю Яндекс!\n\nВы приняты в Яндекс');
  
  final List<EmailContact> _contacts = [];
  bool _isSending = false;
  String _statusMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _smtpHostController.dispose();
    _smtpPortController.dispose();
    _senderEmailController.dispose();
    _senderPasswordController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _addContact() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      _showMessage('Пожалуйста, заполните все поля');
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      _showMessage('Неверный формат email');
      return;
    }

    setState(() {
      _contacts.add(EmailContact(
        name: _nameController.text,
        email: _emailController.text,
      ));
      _nameController.clear();
      _emailController.clear();
    });

    _showMessage('Контакт добавлен');
  }


  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _sendEmailsToAll() async {
    if (_contacts.isEmpty) {
      _showMessage('Добавьте контакты для отправки');
      return;
    }

    if (_senderEmailController.text.isEmpty || _senderPasswordController.text.isEmpty) {
      _showMessage('Заполните данные SMTP для отправки');
      return;
    }

    setState(() {
      _isSending = true;
      _statusMessage = 'Отправка писем...';
    });

    try {
      final smtpServer = SmtpServer(
        _smtpHostController.text,
        port: int.tryParse(_smtpPortController.text) ?? 587,
        username: _senderEmailController.text,
        password: _senderPasswordController.text,
        allowInsecure: true,
        ignoreBadCertificate: true,
      );

      
      ByteData imageData;
      String base64Image;
      Uint8List imageBytes;
      File? tempImageFile;
      
      try {
        imageData = await rootBundle.load('assets/photo.jpg');
        imageBytes = imageData.buffer.asUint8List();
        
        
        base64Image = convert.base64Encode(imageBytes);
        
        
        final tempDir = await getTemporaryDirectory();
        tempImageFile = File('${tempDir.path}/photo.jpg');
        await tempImageFile.writeAsBytes(imageBytes);
      } catch (e) {
        setState(() {
          _isSending = false;
          _statusMessage = 'Ошибка загрузки изображения: $e';
        });
        _showMessage('Ошибка загрузки изображения из assets');
        return;
      }

      int successCount = 0;
      int failCount = 0;

      for (int i = 0; i < _contacts.length; i++) {
        final contact = _contacts[i];
        
        setState(() {
          _statusMessage = 'Отправка письма ${i + 1} из ${_contacts.length} (${contact.name})...';
        });

        try {
          
          final personalizedMessage = _messageController.text.replaceAll('[Имя]', contact.name);
          final personalizedSubject = _subjectController.text.replaceAll('[Имя]', contact.name);
          final emailSubject = personalizedSubject.trim().isEmpty ? 'Привет!' : personalizedSubject;
          
          
          final htmlMessage = personalizedMessage.replaceAll('\n', '<br>');
          
          debugPrint('Отправка письма с темой: $emailSubject');
          
          
          final message = Message()
            ..from = Address(_senderEmailController.text)
            ..recipients.add(contact.email)
            ..subject = emailSubject
            ..text = personalizedMessage
            ..html = '''
              <html>
                <head>
                  <meta charset="UTF-8">
                </head>
                <body>
                  <p style="color: red; font-size: 16px;">
                    $htmlMessage
                  </p>
                  <div style="margin-top: 20px;">
                    <img src="data:image/jpeg;base64,$base64Image" style="max-width: 600px; height: auto;" alt="Photo"/>
                  </div>
                </body>
              </html>
            '''
            ..attachments = [
              FileAttachment(
                tempImageFile!,
                fileName: 'photo.jpg',
                contentType: 'image/jpeg',
              ),
            ];

          await send(message, smtpServer);
          successCount++;
          
          
          if (i < _contacts.length - 1) {
            await Future.delayed(const Duration(seconds: 2));
          }
        } catch (e) {
          failCount++;
          debugPrint('Ошибка отправки письма ${contact.email}: $e');
        }
      }

      
      try {
        if (tempImageFile != null && await tempImageFile.exists()) {
          await tempImageFile.delete();
        }
      } catch (e) {
        debugPrint('Ошибка удаления временного файла: $e');
      }

      setState(() {
        _isSending = false;
        _statusMessage = 'Отправка завершена: $successCount успешно, $failCount ошибок';
      });

      _showMessage('Письма отправлены! Успешно: $successCount, Ошибок: $failCount');
    } catch (e) {
      setState(() {
        _isSending = false;
        _statusMessage = 'Ошибка: $e';
      });
      _showMessage('Ошибка отправки: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lab 9 - Email Spam'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              ExpansionTile(
                title: const Text('Настройки SMTP'),
              initiallyExpanded: false,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _smtpHostController,
                        decoration: const InputDecoration(
                          labelText: 'SMTP Host',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _smtpPortController,
                        decoration: const InputDecoration(
                          labelText: 'SMTP Port',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _senderEmailController,
                        decoration: const InputDecoration(
                          labelText: 'Ваш Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _senderPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Настройки письма',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Тема письма',
                        border: OutlineInputBorder(),
                        hintText: 'Привет, [Имя]',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Текст письма',
                        border: OutlineInputBorder(),
                        hintText: 'Используйте [Имя] для подстановки имени',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Добавить контакт',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Имя',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addContact,
                      label: const Text('Добавить'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            
            if (_statusMessage.isNotEmpty)
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      if (_isSending)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      if (_isSending) const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _statusMessage,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_statusMessage.isNotEmpty) const SizedBox(height: 16),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Контакты',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isSending ? null : _sendEmailsToAll,
                  icon: const Icon(Icons.send),
                  label: const Text('Заспамить'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            _contacts.isEmpty
                ? Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      'Нет контактов',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Card(
                    elevation: 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Имя')),
                          DataColumn(label: Text('Email')),
                        ],
                        rows: _contacts.map((contact) {
                          return DataRow(
                            cells: [
                              DataCell(Text(contact.name)),
                              DataCell(Text(contact.email)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
