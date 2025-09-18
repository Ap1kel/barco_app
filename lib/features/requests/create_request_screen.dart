import 'package:flutter/material.dart';
import '../../services/api_client.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});
  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _type;
  String? _duration;
  bool _electrical = false;

  final _addressController = TextEditingController();
  final _commentController = TextEditingController();

  bool _sending = false;

  static const _types = ['мелкий ремонт', 'капитальный ремонт', 'Демонтаж'];
  static const _durations = [
    '1 день',
    '3 дня',
    '1 неделя',
    '2 недели',
    '1 месяц',
  ];

  Future<void> _submit() async {
    if (!((_formKey.currentState?.validate()) ?? false) ||
        _type == null ||
        _duration == null)
      return;
    setState(() => _sending = true);
    try {
      final api = ApiClient();
      await api.createRequest(
        type: _type!,
        address: _addressController.text.trim(),
        comment: _commentController.text.trim().isEmpty
            ? null
            : _commentController.text.trim(),
        duration: _duration!,
        electrical: _electrical,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Заявка отправлена')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnChild = _sending
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Сохранить');

    return Scaffold(
      appBar: AppBar(title: const Text('Новая заявка')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Тип заявки',
                border: OutlineInputBorder(),
              ),
              value: _type,
              items: _types
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _type = v),
              validator: (v) => v == null ? 'Выберите тип' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Срок ремонта',
                border: OutlineInputBorder(),
              ),
              value: _duration,
              items: _durations
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => _duration = v),
              validator: (v) => v == null ? 'Выберите срок' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Адрес',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Укажите адрес' : null,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Ремонт электроцепи'),
              value: _electrical,
              onChanged: (v) => setState(() => _electrical = v),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Комментарий (необязательно)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _sending ? null : _submit, child: btnChild),
          ],
        ),
      ),
    );
  }
}
