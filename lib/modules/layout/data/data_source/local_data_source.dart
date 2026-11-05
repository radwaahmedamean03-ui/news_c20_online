import 'package:news_c20_online/core/services/hive_service.dart';

abstract class LocalDataSource {
  Future<void> saveNews(dynamic data);

  Future<dynamic> getNews();
}

class LocalDataSourceImp extends LocalDataSource {
  @override
  Future<dynamic> getNews() async {
    var ref = await HiveService.getRef();
    var box = await ref.openBox("news");
    var data = await box.get("articles");
    ref.close();
    return data;
  }

  @override
  Future<void> saveNews(data) async {
    var ref = await HiveService.getRef();
    var box = await ref.openBox("news");
    await box.put("articles", data);
    ref.close();
  }
}
