import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/index.dart';

class FloorPlanDetailScreen extends ConsumerWidget {
  final String floorPlanId;

  const FloorPlanDetailScreen({
    Key? key,
    required this.floorPlanId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor Plan Details'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: AppColors.grey400,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Floor Plan Name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Total Area: 250 m²',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Rooms',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bedroom $index'),
                      const SizedBox(height: AppSpacing.sm),
                      Text('Area: 20 m²', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: 'View 3D',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: PrimaryButton(
                    label: 'Export',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
