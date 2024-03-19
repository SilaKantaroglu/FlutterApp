import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/newsPage/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final Result newsItem;

  const NewsDetailPage(this.newsItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(children: [
          Text(
            newsItem.name ?? '',
            style: const TextStyle(fontSize: 25),
          ),
          const Divider(),
          if (newsItem.image != null)
            Image.network(
              newsItem.image!,
              height: 250,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                color: ColorUtility.white,
                height: 100,
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: ColorUtility.babyBlue,
                    size: 50,
                  ),
                ),
              ),
            )
          else
            Container(
              color: ColorUtility.white,
              height: 100,
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: ColorUtility.babyBlue,
                  size: 50,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            newsItem.description ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            'Kaynak: ${newsItem.source ?? ''}',
            style: const TextStyle(fontSize: 14, color: ColorUtility.grey),
          ),
        ]),
      ),
    );
  }
}
