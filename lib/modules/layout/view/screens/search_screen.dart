import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c20_online/core/services/api_service.dart';
import 'package:news_c20_online/core/theme/app_colors.dart';
import '../../data/models/news_response.dart';
import 'article_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  List<Articles> articles = [];
  bool loading = false;
  String? error;

  Future<void> searchNews(String value) async {
    final query = value.trim();
    if (query.isEmpty) {
      setState(() { articles = []; error = null; loading = false; });
      return;
    }
    setState(() { loading = true; error = null; });
    try {
      final response = await ApiService.dio.get('everything', queryParameters: {'q': query, 'sortBy': 'publishedAt', 'pageSize': 30});
      final result = NewsResponse.fromJson(response.data).articles ?? <Articles>[];
      if (!mounted) return;
      setState(() { articles = result; loading = false; });
    } catch (_) {
      if (!mounted) return;
      setState(() { loading = false; error = 'Could not load news. Check your internet connection and API access.'; });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        title: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textInputAction: TextInputAction.search,
          onSubmitted: searchNews,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: .75)),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Clear search',
            icon: const Icon(Icons.close),
            onPressed: () { controller.clear(); setState(() { articles = []; error = null; }); },
          ),
        ],
      ),
      body: loading
        ? const Center(child: CircularProgressIndicator())
        : error != null
          ? Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(error!, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)))
          : articles.isEmpty
            ? const Center(child: Text('Search for news', style: TextStyle(color: Colors.white70, fontSize: 16)))
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: articles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleDetailsScreen(article: article))),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white54), borderRadius: BorderRadius.circular(14)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if ((article.urlToImage ?? '').isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage!, width: double.infinity, height: 175, fit: BoxFit.cover,
                              placeholder: (_, __) => const SizedBox(height: 175, child: Center(child: CircularProgressIndicator())),
                              errorWidget: (_, __, ___) => const SizedBox(height: 100, child: Icon(Icons.image_not_supported, color: Colors.white70)),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(article.title ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 6),
                        Row(children: [
                          Expanded(child: Text('By: ${article.author ?? article.source?.name ?? 'Unknown'}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white60, fontSize: 11))),
                          Text(article.publishedAt != null && article.publishedAt!.length >= 10 ? article.publishedAt!.substring(0, 10) : '', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                        ]),
                      ]),
                    ),
                  );
                },
              ),
    );
  }
}
