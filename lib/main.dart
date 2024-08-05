// lib/main.dart

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'features/gallery/data/repositories/image_repository.dart';
import 'features/gallery/domain/usecases/capture_image.dart';
import 'features/gallery/presentation/pages/camera/camera_page.dart';
import 'features/gallery/presentation/pages/calendar/calendar_page.dart';
import 'features/gallery/presentation/pages/gallery/gallery_page.dart';
import 'features/gallery/presentation/pages/home/homepage.dart';
import 'features/gallery/presentation/pages/provider/camera_provider.dart';
import 'features/utilities/colors.dart';
import 'splash_screen.dart';  // Import the SplashScreen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CameraProvider(
            CaptureImage(ImageRepository()),
            (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        home: SplashScreen(cameras: cameras),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  final List<CameraDescription> cameras;
  const NavBar({super.key, required this.cameras});

  @override
  _NavBState createState() => _NavBState();
}

class _NavBState extends State<NavBar> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const GalleryPage(),
      const CalendarPage(),
      CamPage(cameras: widget.cameras),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: navbackgroundColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(Icons.home_outlined, 0),
                      _buildNavItem(Icons.image_outlined, 1),
                      _buildNavItem(Icons.calendar_today_outlined, 2),
                      _buildNavItem(Icons.camera_alt_outlined, 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 28.0,
        ),
      ),
    );
  }
}