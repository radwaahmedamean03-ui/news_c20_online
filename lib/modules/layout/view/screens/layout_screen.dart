import 'package:flutter/material.dart';
import 'package:news_c20_online/core/categorise/app_categories.dart';
import 'package:news_c20_online/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../manager/layout_provider.dart';
import 'articles_screen.dart';
import 'category_screen.dart';
import 'search_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: AppBar(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              centerTitle: true,
              title: Text(provider.selectedCategory?.name ?? "Home"),
              actions: [
                IconButton(
                  tooltip: 'Search news',
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                ),
              ],
            ),
            drawer: Drawer(
              backgroundColor: AppColors.black,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.white),
                    child: Center(
                      child: Text(
                        "News App",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.goToHome();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.home, color: AppColors.white, size: 34),
                          SizedBox(width: 16),
                          Text(
                            "GO To Home",
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            body: provider.selectedCategory != null
                ? ArticlesScreen()
                : CategoryScreen(),
          );
        },
      ),
    );
  }
}
