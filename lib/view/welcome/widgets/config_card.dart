import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ConfigCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const ConfigCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColor.primary : AppColor.grey2,
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: [
              if (!isSelected)
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
                  color:
                      isSelected
                          ? AppColor.primary.withAlpha(25)
                          : AppColor.grey1,
                  shape: BoxShape.circle,
                ),
                child:
                    title == "Custom"
                        ? Icon(
                          Icons.edit,
                          size: 24,
                          color: isSelected ? AppColor.primary : AppColor.grey4,
                        )
                        : Icon(
                          Icons.grid_view,
                          size: 24,
                          color: isSelected ? AppColor.primary : AppColor.grey4,
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
                        color: AppColor.grey5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.grey3,
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
            ],
          ),
        ),
      ),
    );
  }
}
