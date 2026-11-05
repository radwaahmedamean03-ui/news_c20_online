import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/categorise/app_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../manager/layout_provider.dart';
import '../widegts/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Good Morning\nHere is Some News For You",
                style: TextStyle(fontSize: 24, color: AppColors.white),
              ),

              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: AppCategory.categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        provider.onChanceCategory(
                          AppCategory.categories[index],
                        );
                      },
                      child: CategoryWidget(
                        category: AppCategory.categories[index],
                        isLeft: index % 2 == 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
