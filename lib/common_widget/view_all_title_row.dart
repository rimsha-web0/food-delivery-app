import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class ViewAllTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onView;

  const ViewAllTitleRow({
    super.key,
    required this.title,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          // Title ko expand karo aur overflow handle karo
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // View all button
          TextButton(
            onPressed: onView,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(10, 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "View all",
              style: TextStyle(
                color: TColor.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      )
    );
  }
}