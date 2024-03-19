import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/newsPage/news_card.dart';
import 'package:staj_case/pages/newsPage/news_detail.dart';
import 'package:staj_case/pages/newsPage/news_model.dart';
import 'package:staj_case/pages/newsPage/news_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Result> _newsList = [];
  String _selectedTag = 'general';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    NewsModel? newsModel = await NewsService.fetchNews(tag: _selectedTag);
    if (mounted) {
      setState(() {
        _newsList = newsModel!.result!;
      });
    }
  }

  Future<void> _refreshNews() async {
    await _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: _refreshNews,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: _elevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _selectedTag = 'general';
                      });
                      _fetchNews();
                    },
                    child: Text('Genel', style: _textStyle()),
                  ),
                  ElevatedButton(
                    style: _elevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _selectedTag = 'sport';
                      });
                      _fetchNews();
                    },
                    child: Text('Spor', style: _textStyle()),
                  ),
                  ElevatedButton(
                    style: _elevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _selectedTag = 'economy';
                      });
                      _fetchNews();
                    },
                    child: Text('Ekonomi', style: _textStyle()),
                  ),
                  ElevatedButton(
                    style: _elevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _selectedTag = 'technology';
                      });
                      _fetchNews();
                    },
                    child: Text('Teknoloji', style: _textStyle()),
                  ),
                ],
              ),
              Expanded(
                child: _newsList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.01,
                          mainAxisSpacing: 0.01,
                        ),
                        itemCount: _newsList.length,
                        itemBuilder: (context, index) {
                          Result newsItem = _newsList[index];
                          return NewsCard(
                            name: newsItem.name,
                            source: newsItem.source,
                            description: newsItem.description,
                            imageUrl: newsItem.image,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(newsItem),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() => TextStyle(color: ColorUtility.purple, fontSize: 15, fontWeight: FontWeight.w600);

  ButtonStyle _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.white,
        foregroundColor: ColorUtility.white,
        shadowColor: ColorUtility.darkBabyBlueButton);
  }
}
