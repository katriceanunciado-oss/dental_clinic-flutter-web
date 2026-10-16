import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dental Clinic Login')),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420),
        child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.lock_outline, size: 56, color: Colors.teal),
          const SizedBox(height: 16),
          Text('Login preview', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          const Text('UI demonstration only. Use sample values; no account is created or authenticated.', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          const AppTextField(label: 'Username'),
          const SizedBox(height: 16),
          const AppTextField(label: 'Password', obscureText: true),
          const SizedBox(height: 20),
          AppButton(label: 'Preview Login', onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Form checked. Authentication will be implemented in a later activity.')));
            }
          }),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Home')),
        ])),
      ),
    )),
  );
}
