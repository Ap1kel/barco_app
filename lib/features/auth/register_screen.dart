import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final void Function(String, String) onRegister;
  final VoidCallback onSwitch;
  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onSwitch,
  });
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _user,
              decoration: const InputDecoration(labelText: 'Логин'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pass,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => widget.onRegister(_user.text, _pass.text),
              child: const Text('Зарегистрироваться'),
            ),
            TextButton(
              onPressed: widget.onSwitch,
              child: const Text('Уже есть аккаунт? Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
