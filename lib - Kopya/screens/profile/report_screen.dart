import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/index.dart';

class ReportScreen extends ConsumerWidget {
  final String floorPlanId;

  const ReportScreen({
    Key? key,
    required this.floorPlanId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.primary),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property Report',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Generated on December 20, 2024',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Summary',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            _ReportSection(
              title: 'Property Information',
              content: [
                _ReportField('Address', '123 Main Street, City, State'),
                _ReportField('Type', 'Residential'),
                _ReportField('Year Built', '2020'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _ReportSection(
              title: 'Measurements',
              content: [
                _ReportField('Total Area', '250 m²'),
                _ReportField('Living Area', '200 m²'),
                _ReportField('Rooms', '5'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _ReportSection(
              title: 'Rooms Details',
              content: [
                _ReportField('Bedroom 1', '20 m²'),
                _ReportField('Bedroom 2', '18 m²'),
                _ReportField('Living Room', '40 m²'),
                _ReportField('Kitchen', '15 m²'),
                _ReportField('Bathroom', '8 m²'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Share Report',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportSection extends StatelessWidget {
  final String title;
  final List<_ReportField> content;

  const _ReportSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            ...content.map((field) => field),
          ],
        ),
      ),
    );
  }
}

class _ReportField extends StatelessWidget {
  final String label;
  final String value;

  const _ReportField(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
