import 'package:flutter/material.dart';
import '../../../shell/main_shell.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isAuthenticated = false;
  bool _showLogin = true;

  void _login(String u, String p) => setState(() => _isAuthenticated = true);
  void _register(String u, String p) => setState(() => _isAuthenticated = true);
  void _toggle() => setState(() => _showLogin = !_showLogin);

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) return const MainShell();
    return _showLogin
        ? LoginScreen(onLogin: _login, onSwitch: _toggle)
        : RegisterScreen(onRegister: _register, onSwitch: _toggle);
  }
}
