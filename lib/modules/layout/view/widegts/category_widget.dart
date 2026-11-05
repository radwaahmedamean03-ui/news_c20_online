import 'package:flutter/material.dart';
import 'package:news_c20_online/core/categorise/app_categories.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  AppCategory category;
  bool isLeft;
  CategoryWidget({super.key, required this.category, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        textDirection: isLeft? TextDirection.ltr  : TextDirection.rtl,
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(category.image)),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(category.name, style: TextStyle(fontSize: 30)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: AppColors.black.withValues(alpha: 0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: isLeft? TextDirection.ltr  : TextDirection.rtl,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View All",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.white,
                        child: Icon(isLeft ? Icons.arrow_forward_ios_rounded :Icons.arrow_back_ios_rounded ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
