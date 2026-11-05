import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/news_response.dart';
import 'article_details_screen.dart';
import '../manager/layout_provider.dart';


class ArticlesScreen extends StatelessWidget {
  ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            DefaultTabController(
              length: provider.sources.length,
              child: TabBar(
                onTap: (value) {
                  provider.onChangeSource(provider.sources[value]);
                },
                dividerColor: Colors.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.white,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.white,
                tabs: provider.sources.map((e) {
                  return Tab(text: e.name ?? "");
                }).toList(),
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final article = provider.articles[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (sheetContext) => _ArticlePreview(
                          article: article,
                          onViewFullArticle: () {
                            Navigator.pop(sheetContext);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ArticleDetailsScreen(article: article),
                            ));
                          },
                        ),
                      );
                    },
                    child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:  article.urlToImage ??"",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                        ),
                        // Image.network(article.urlToImage ?? ""),
                        SizedBox(height: 12),
                        Text(
                          article.title ?? "",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "By : ${article.author ?? ""}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Text(
                              article.publishedAt != null && article.publishedAt!.length >= 10 ? article.publishedAt!.substring(0, 10) : "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemCount: provider.articles.length,
              ),
            ),
          ],
        );
      },
    );
  }
}


class _ArticlePreview extends StatelessWidget {
  final Articles article;
  final VoidCallback onViewFullArticle;
  const _ArticlePreview({required this.article, required this.onViewFullArticle});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage ?? '';
    final description = article.description ?? '';
    final content = article.content ?? '';
    final preview = description.isNotEmpty ? description : content;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: double.infinity, height: 190, fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(height: 190, child: Center(child: CircularProgressIndicator())),
                  errorWidget: (_, __, ___) => const SizedBox(height: 100, child: Icon(Icons.image_not_supported)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 10),
              child: Text(
                '${article.title ?? ''}\n$preview',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 13, height: 1.3),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onViewFullArticle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('View Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
