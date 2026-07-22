import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final String? title, body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Notifications tapped');
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).hideCurrentSnackBar();
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? '', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 1),
            Text(
              body ?? '',
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
