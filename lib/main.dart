import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:web_navbar/widgets/navbar.dart';

import 'provider/themeProvider/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ref.watch(themeStateProvider),
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 320, name: "SMALL_MOBILE"),
          const Breakpoint(start: 321, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ],
      ),
      home: const WebsiteNav(),
    );
  }
}
