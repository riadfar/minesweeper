import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const ModeCard({super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        splashColor: isEnabled ? null : Colors.transparent,
        highlightColor: isEnabled ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isEnabled ? AppColor.white : AppColor.grey1,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isEnabled
                  ? (isSelected ? AppColor.primary : AppColor.grey2)
                  : AppColor.grey2,
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: [
              if (isEnabled && !isSelected)
                BoxShadow(
                  color: Colors.grey.withAlpha(25),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isEnabled
                      ? (isSelected
                      ? AppColor.primary.withAlpha(25)
                      : AppColor.grey1)
                      : AppColor.grey1,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isEnabled
                      ? (isSelected ? AppColor.primary : AppColor.grey4)
                      : AppColor.grey3,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isEnabled ? AppColor.grey5 : AppColor.grey3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isEnabled ? AppColor.grey3 : AppColor.grey2,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColor.primary,
                  size: 24,
                ),
              if (!isEnabled)
                Text(
                  'Coming Soon',
                  style: TextStyle(
                    color: AppColor.grey3,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}