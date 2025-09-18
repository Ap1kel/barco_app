import 'package:flutter/material.dart';
import '../theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Контроллеры (пригодятся для валидации/отправки данных)
  final _orgName = TextEditingController();
  final _inn = TextEditingController();
  final _kpp = TextEditingController();
  final _ogrn = TextEditingController();
  final _legalAddress = TextEditingController();
  final _fio = TextEditingController();
  final _position = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _orgName.dispose();
    _inn.dispose();
    _kpp.dispose();
    _ogrn.dispose();
    _legalAddress.dispose();
    _fio.dispose();
    _position.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Banner(),
          const SizedBox(height: 16),

          const _SectionTitle('Основное'),
          _Field(controller: _orgName, hint: 'Название организации *'),
          _Field(
            controller: _inn,
            hint: 'ИНН *',
            keyboard: TextInputType.number,
          ),
          _Field(
            controller: _kpp,
            hint: 'КПП *',
            keyboard: TextInputType.number,
          ),
          _Field(
            controller: _ogrn,
            hint: 'ОГРН *',
            keyboard: TextInputType.number,
          ),
          _Field(controller: _legalAddress, hint: 'Юр. адрес *'),

          const SizedBox(height: 20),
          const _SectionTitle('Контакты'),
          _Field(controller: _fio, hint: 'ФИО *'),
          _Field(controller: _position, hint: 'Должность'),
          _Field(
            controller: _phone,
            hint: 'Номер телефона *',
            keyboard: TextInputType.phone,
          ),
          _Field(
            controller: _email,
            hint: 'Email',
            keyboard: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),
          const _SectionTitle('Адреса объектов'),
          const _AddAddressRow(),

          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // Здесь позже добавим валидацию и отправку формы
                Navigator.pushReplacementNamed(context, '/main');
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Продолжить'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF), // светло-синий фон (под бренд)
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text('Приступим к работам в должный срок!'),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(color: kOrange), // акцентный оранжевый
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final TextInputType? keyboard;

  const _Field({required this.hint, this.controller, this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}

class _AddAddressRow extends StatelessWidget {
  const _AddAddressRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: _Field(hint: 'Добавить адрес')),
        const SizedBox(width: 8),
        FilledButton.tonal(
          onPressed: () {
            // здесь позже сделаем добавление в список адресов
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
