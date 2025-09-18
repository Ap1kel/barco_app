import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/api_client.dart';
import 'create_request_screen.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final _api = ApiClient();
  bool _loading = true;
  String? _error;
  List<Request> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _api.fetchRequests();
      setState(() => _items = data);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _openCreate() async {
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const CreateRequestScreen()),
    );
    if (ok == true) _load();
  }

  Future<void> _changeStatus(int index, String status) async {
    final id = _items[index].id;
    try {
      final updated = await _api.updateStatus(id, status);
      setState(() => _items[index] = updated);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка смены статуса: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
        floatingActionButton: _RequestsFabDisabled(),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ошибка: $_error'),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: _load, child: const Text('Повторить')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openCreate,
          child: const Icon(Icons.add),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreate,
        child: const Icon(Icons.add),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Нет заявок'))
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _items.length,
                itemBuilder: (_, i) {
                  final r = _items[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        r.type.isNotEmpty
                            ? r.type.characters.first.toUpperCase()
                            : '?',
                      ),
                    ),
                    title: Text(r.type),
                    subtitle: Text(
                      [
                        r.address,
                        if (r.comment != null && r.comment!.isNotEmpty)
                          r.comment!,
                        'Статус: ${r.status}',
                      ].join('\n'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (s) => _changeStatus(i, s),
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'new', child: Text('new')),
                        PopupMenuItem(
                          value: 'assigned',
                          child: Text('assigned'),
                        ),
                        PopupMenuItem(
                          value: 'in_progress',
                          child: Text('in_progress'),
                        ),
                        PopupMenuItem(value: 'done', child: Text('done')),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
              ),
            ),
    );
  }
}

class _RequestsFabDisabled extends StatelessWidget {
  const _RequestsFabDisabled();
  @override
  Widget build(BuildContext context) {
    return const FloatingActionButton(onPressed: null, child: Icon(Icons.add));
  }
}
