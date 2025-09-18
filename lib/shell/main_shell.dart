import 'package:flutter/material.dart';
import '../features/profile/profile_screen.dart';
import '../features/requests/requests_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  List<Widget> get _pages => const [
    _HomePlaceholder(),
    RequestsPage(),
    Center(child: Text('Объекты')),
    Center(child: Text('Отчёты')),
    Center(child: Text('Чат')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Главная', 'Заявки', 'Объекты', 'Отчёты', 'Чат'][_index]),
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            label: 'Заявки',
          ),
          NavigationDestination(
            icon: Icon(Icons.apartment_outlined),
            label: 'Объекты',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Отчёты',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Чат',
          ),
        ],
      ),
    );
  }
}

class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
        child: const Text('Личный кабинет'),
      ),
    );
  }
}
