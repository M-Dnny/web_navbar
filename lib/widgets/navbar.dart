import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_navbar/provider/themeProvider/theme_provider.dart';
import 'package:web_navbar/screens/aboutus.dart';
import 'package:web_navbar/screens/home.dart';

class WebsiteNav extends ConsumerStatefulWidget {
  const WebsiteNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebsiteNavState();
}

final currentStateProvider = StateProvider<int>((ref) => 0);

final screenList = [
  const HomeScreen(),
  const AboutUsScreen(),
];

class _WebsiteNavState extends ConsumerState<WebsiteNav> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentStateProvider);
    final themeMode = ref.watch(themeStateProvider);
    const lightMode = ThemeMode.light;
    const darkMode = ThemeMode.dark;

    changeTheme() {
      ref.watch(themeStateProvider.notifier).state =
          themeMode == lightMode ? darkMode : lightMode;
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 80,
        title: const Text("Web Navbar"),
        actions: [
          NavBarItem(
            title: "Home",
            index: 0,
            currentIndex: currentIndex,
          ),
          const SizedBox(width: 20),
          NavBarItem(
            title: "About Us",
            index: 1,
            currentIndex: currentIndex,
          ),
          const SizedBox(width: 20),
          TextButton.icon(
            onPressed: () {
              changeTheme();
            },
            label: Text(themeMode != lightMode ? "Dark Mode" : "Light Mode"),
            icon: Icon(themeMode == lightMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screenList[currentIndex],
        transitionBuilder: (child, animation) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class NavBarItem extends ConsumerWidget {
  final String title;
  final int currentIndex;
  final int index;
  const NavBarItem({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = index == currentIndex;
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(.3),
      onTap: () {
        ref.read(currentStateProvider.notifier).state = index;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: .2,
              blurRadius: 2,
              color: isSelected ? Colors.black54 : Colors.transparent,
            )
          ],
          color: isSelected
              ? Theme.of(context).colorScheme.inversePrimary
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
