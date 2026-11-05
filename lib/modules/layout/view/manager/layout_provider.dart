import 'package:flutter/material.dart';
import 'package:news_c20_online/modules/layout/data/models/news_response.dart';
import 'package:news_c20_online/modules/layout/data/repo/repo.dart';
import '../../../../core/categorise/app_categories.dart';
import '../../data/models/sources_response.dart';

class LayoutProvider extends ChangeNotifier {
  AppCategory? selectedCategory;
  Sources? selectedSource;

  List<Sources> sources = [];
  List<Articles> articles = [];

  Repo repo = RepoImp();

  void onChanceCategory(AppCategory category) {
    selectedCategory = category;
    getSources();
    notifyListeners();
  }

  void goToHome() {
    selectedCategory = null;
    sources = [];
    selectedSource = null;
    notifyListeners();
  }

  void onChangeSource(Sources source) {
    selectedSource = source;
    articles = [];
    getNews();
    notifyListeners();
  }

  Future<void> getSources() async {
    try {
      sources = await repo.getSources(selectedCategory!.id);
      selectedSource = sources.first;
    } catch (e) {
      getNews();
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getNews()async{
    try{
      articles = await repo.getNews(selectedSource?.id??"");
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
}
