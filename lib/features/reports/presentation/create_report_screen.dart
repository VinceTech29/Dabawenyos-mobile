import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dabawenyos/core/theme/app_theme.dart';
import 'package:dabawenyos/core/providers/app_providers.dart';

class CreateReportScreen extends ConsumerStatefulWidget {
  const CreateReportScreen({super.key});

  @override
  ConsumerState<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends ConsumerState<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = 'Pothole';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _barangayController = TextEditingController();
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Pothole',
    'Flooding',
    'Streetlight',
    'Garbage',
    'Drainage',
    'Road Damage',
    'Fallen Tree',
    'Stray Animal',
    'Traffic Signal',
    'Illegal Parking',
  ];

  final List<String> _barangays = [
    'Poblacion',
    'Talomo',
    'Agdao',
    'Buhangin',
    'Toril',
    'Matina Aplaya',
    'Matina Crossing',
    'Calinan',
    'Sasa',
    'Mintal',
    'Catalunan Grande',
    'Bunawan',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _barangayController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      ref.read(reportsProvider.notifier).addReport(
        category: _selectedCategory,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        barangay: _barangayController.text.trim().isEmpty ? null : _barangayController.text.trim(),
      );

      setState(() => _isSubmitting = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 48),
          title: const Text('Report Submitted Locally'),
          content: const Text(
            'Thank you for reporting! Your concern has been cataloged under community submissions. '
            'In future updates, this will sync directly to Davao City local operations.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              child: const Text('Back to Reports'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('File a Community Report'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Picker
              const Text(
                'Select Issue Category *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                items: _categories.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category_outlined, color: AppColors.primary),
                ),
              ),

              const SizedBox(height: 18),

              // Title
              const Text(
                'Short Title / Summary *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Deep pothole blocking lane',
                  prefixIcon: Icon(Icons.title, color: AppColors.primary),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter a title' : null,
              ),

              const SizedBox(height: 18),

              // Location
              const Text(
                'Specific Street or Landmark *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  hintText: 'e.g. In front of Gaisano Mall, JP Laurel',
                  prefixIcon: Icon(Icons.pin_drop_outlined, color: AppColors.primary),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please provide location' : null,
              ),

              const SizedBox(height: 18),

              // Barangay Selection
              const Text(
                'Barangay (Optional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                items: _barangays.map((b) {
                  return DropdownMenuItem(value: b, child: Text(b));
                }).toList(),
                onChanged: (val) {
                  if (val != null) _barangayController.text = val;
                },
                decoration: const InputDecoration(
                  hintText: 'Select Davao Barangay',
                  prefixIcon: Icon(Icons.home_work_outlined, color: AppColors.primary),
                ),
              ),

              const SizedBox(height: 18),

              // Description
              const Text(
                'Detailed Description *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Describe how long the issue has persisted, danger level, etc...',
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please provide a description' : null,
              ),

              const SizedBox(height: 18),

              // Photo Placeholder Box
              const Text(
                'Photo Proof (Optional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 36, color: AppColors.primary.withValues(alpha: 0.7)),
                    const SizedBox(height: 8),
                    const Text(
                      'Attach photo from Camera or Gallery',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Max file size: 5MB (Simulated)',
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Submit button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Submit Community Report',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
