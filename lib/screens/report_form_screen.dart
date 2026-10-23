import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState { idle, loading, success, empty, error }

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // Temporary records only; no backend is connected.
  final List<Map<String, String>> _reports = [];
  ReportUiState _uiState = ReportUiState.empty;
  bool _simulateFailure = false;
  bool get _isLoading => _uiState == ReportUiState.loading;

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validate(String? value, String label, int minimum) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter $label.';
    if (text.length < minimum) return 'Enter at least $minimum characters.';
    return null;
  }

  Future<void> _submitReport() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final report = <String, String>{
      'name': _nameController.text.trim(),
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
    };
    final shouldFail = _simulateFailure;
    setState(() => _uiState = ReportUiState.loading);
    try {
      // Simulated asynchronous request, not a real database submission.
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      if (shouldFail) throw Exception('Simulated submission failure');
      setState(() {
        _reports.add(report);
        _uiState = ReportUiState.success;
      });
      _formKey.currentState!.reset();
      _nameController.clear();
      _titleController.clear();
      _descriptionController.clear();
    } catch (_) {
      if (!mounted) return;
      setState(() => _uiState = ReportUiState.error);
    }
  }

  void _retryReport() {
    if (_isLoading) return;
    // Simulate a recovered connection on retry.
    setState(() => _simulateFailure = false);
    _submitReport();
  }

  void _createAnotherReport() {
    if (_isLoading) return;
    setState(() => _uiState = ReportUiState.idle);
  }

  void _clearDemoReports() {
    if (_isLoading) return;
    setState(() {
      _reports.clear();
      _uiState = ReportUiState.empty;
    });
  }

  Widget _statusCard({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
    required Widget action,
  }) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          action,
        ],
      ),
    ),
  );

  Widget _buildStatus() {
    switch (_uiState) {
      case ReportUiState.loading:
        return const Card(child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Loading', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Submitting your report...\nSimulated request. Please wait.',
              textAlign: TextAlign.center),
          ]),
        ));
      case ReportUiState.success:
        return _statusCard(
          icon: Icons.check_circle_outline, color: Colors.green, title: 'Success',
          message: 'Simulated submission completed.\nThe report was added to the '
              'temporary list below. No database record was created.',
          action: AppButton(label: 'Create Another Report', onPressed: _createAnotherReport),
        );
      case ReportUiState.empty:
        return _statusCard(
          icon: Icons.inbox_outlined, color: Colors.blueGrey, title: 'Empty',
          message: 'No reports available.\nCreate a dental clinic report using the form below.',
          action: AppButton(label: 'Create a Report', onPressed: _createAnotherReport),
        );
      case ReportUiState.error:
        return _statusCard(
          icon: Icons.error_outline, color: Colors.red, title: 'Error',
          message: 'Simulated submission failure.\nYour input is still available. '
              'Retry will turn off the simulated failure and try again.',
          action: AppButton(label: 'Retry', onPressed: _retryReport),
        );
      case ReportUiState.idle:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dental Clinic Report Form')),
    body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('Activity 9 — Simulated Report Submission', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Use sample patient information. Reports are temporary and disappear '
              'when you leave this screen or reload the app.', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Semantics(liveRegion: true, child: _buildStatus()),
          const SizedBox(height: 16),
          Form(key: _formKey, child: Column(children: [
            AppTextField(label: 'Patient Name', controller: _nameController,
              enabled: !_isLoading, validator: (v) => _validate(v, 'the patient name', 2)),
            const SizedBox(height: 16),
            AppTextField(label: 'Report Title', controller: _titleController,
              enabled: !_isLoading, validator: (v) => _validate(v, 'a report title', 5)),
            const SizedBox(height: 16),
            AppTextField(label: 'Dental Clinic Concern', controller: _descriptionController,
              enabled: !_isLoading, maxLines: 3,
              validator: (v) => _validate(v, 'the dental clinic concern', 10)),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Simulate submission failure'),
              subtitle: const Text('Turn on to demonstrate the Error state.'),
              value: _simulateFailure,
              onChanged: _isLoading ? null : (value) => setState(() => _simulateFailure = value),
            ),
            const SizedBox(height: 12),
            AppButton(label: _isLoading ? 'Submitting...' : 'Submit Report',
              onPressed: _isLoading ? null : _submitReport),
          ])),
          const SizedBox(height: 24),
          if (_reports.isNotEmpty) ...[
            Text('Temporary Reports (${_reports.length})',
              style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final report in _reports)
              Card(child: ListTile(
                leading: const Icon(Icons.description_outlined, color: Colors.teal),
                title: Text(report['title']!),
                subtitle: Text('Patient: ${report['name']}\n${report['description']}'),
                isThreeLine: true,
              )),
            const SizedBox(height: 8),
            AppButton(label: 'Clear Demo Reports',
              onPressed: _isLoading ? null : _clearDemoReports),
          ],
          const SizedBox(height: 12),
          TextButton(onPressed: _isLoading ? null : () => Navigator.pop(context),
            child: const Text('Back to Home')),
        ]),
      ),
    )),
  );
}
