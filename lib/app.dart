import 'package:flutter/material.dart';

import 'core/theme/finora_theme.dart';
import 'features/shell/finora_shell.dart';

class FinoraApp extends StatefulWidget {
  const FinoraApp({super.key});

  @override
  State<FinoraApp> createState() => _FinoraAppState();
}

class _FinoraAppState extends State<FinoraApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finora',
      debugShowCheckedModeBanner: false,
      theme: FinoraTheme.light,
      darkTheme: FinoraTheme.dark,
      themeMode: _themeMode,
      home: FinoraShell(onToggleTheme: _toggleTheme),
    );
  }
}