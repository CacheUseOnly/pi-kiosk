import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'themes/theme.dart';
import 'Pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    backgroundColor: Colors.transparent,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WindowListener {
  // Themes
  ThemeMode _themeMode = ThemeMode.light;

  bool _isInFullscreen = false;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _changeTheme() {
    setState(() {
      if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    });
  }

  @override
  void onWindowEnterFullScreen() {
    _isInFullscreen = true;
  }

  @override
  void onWindowLeaveFullScreen() {
    _isInFullscreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: Container(
        decoration: BoxDecoration(
            color:
                (_themeMode == ThemeMode.dark) ? Colors.orange : Colors.blue),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  onPressed: () async {
                    await windowManager.setFullScreen(!_isInFullscreen);
                  },
                  mini: true,
                  backgroundColor: (_themeMode == ThemeMode.dark)
                      ? Colors.orange[400]
                      : Colors.orange[100],
                  child: (_isInFullscreen)
                      ? Icon(
                          Icons.fullscreen_exit_rounded,
                          color: (_themeMode == ThemeMode.dark)
                              ? Colors.white
                              : Colors.black,
                        )
                      : Icon(
                          Icons.fullscreen_rounded,
                          color: (_themeMode == ThemeMode.dark)
                              ? Colors.white
                              : Colors.black,
                        )),
              const SizedBox(
                height: 8,
              ),
              FloatingActionButton(
                onPressed: _changeTheme,
                backgroundColor: (_themeMode == ThemeMode.dark)
                    ? Colors.orange[600]
                    : Colors.orange[300],
                child: Icon(
                  Icons.contrast_rounded,
                  color: (_themeMode == ThemeMode.dark)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          body: const Center(
            child: SizedBox(
              height: 200,
              width: 400,
              child: HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
