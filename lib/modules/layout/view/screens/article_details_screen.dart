import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/news_response.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Articles article;
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final title = article.title ?? 'News';
    final date = article.publishedAt;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white ,
        foregroundColor: AppColors.black ,
        title: const Text('abc NEWS', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, height: 1.15, color: AppColors.black)),
              const SizedBox(height: 10),
              Text(article.description ?? '', style: const TextStyle(fontSize: 14, color: AppColors.black )),
              const SizedBox(height: 14),
              Text('By ${article.author?.isNotEmpty == true ? article.author : (article.source?.name ?? 'News Desk')}',
                style: const TextStyle(fontSize: 12, color: Colors.blue, decoration: TextDecoration.underline)),
              const SizedBox(height: 4),
              Text(date != null && date.length >= 10 ? date.substring(0, 10) : '',
                style: const TextStyle(fontSize: 12, color: AppColors.black )),
              const SizedBox(height: 16),
              Row(children: [
                _ShareIcon(icon: Icons.facebook),
                _ShareIcon(icon: Icons.close),
                _ShareIcon(icon: Icons.email_outlined),
                _ShareIcon(icon: Icons.link),
              ]),
              const SizedBox(height: 14),
              if ((article.urlToImage ?? '').isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const SizedBox(height: 210, child: Center(child: CircularProgressIndicator())),
                    errorWidget: (_, __, ___) => const SizedBox(height: 160, child: Center(child: Icon(Icons.image_not_supported_outlined, size: 48))),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                [article.description, article.content].where((part) => part != null && part.trim().isNotEmpty).join('\n\n'),
                style: const TextStyle(fontSize: 16, height: 1.55, color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  const _ShareIcon({required this.icon});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 22),
    child: Icon(icon, size: 18, color: AppColors.black),
  );
}
