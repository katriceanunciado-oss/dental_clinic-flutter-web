import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(AppConstants.title)),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.local_hospital_outlined, size: 72, color: Colors.teal),
          const SizedBox(height: 20),
          Text('Welcome to our Dental Clinic', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          const Text(AppConstants.description, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          AppButton(label: 'Open Login', onPressed: () => Navigator.pushNamed(context, AppRoutes.login)),
          const SizedBox(height: 12),
          const Text('Planned features: appointment booking, dentist schedules and patient records. Activity 8 includes Home and Login only.', textAlign: TextAlign.center),
        ]),
      ),
    )),
  );
}
