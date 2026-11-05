// import 'package:news_c20_online/core/services/api_service.dart';
// import 'package:news_c20_online/modules/layout/data/mdoels/news_response.dart';
// import 'package:news_c20_online/modules/layout/data/mdoels/sources_response.dart';
//
// class ApiManager {
//
//   static Future<List<Articles>> getNews(String sourceId)async{
//     try{
//       var response = await ApiService.dio.get("everything?sources=$sourceId");
//       if(response.statusCode == 200){
//         var data = NewsResponse.fromJson(response.data);
//         return data.articles ?? [];
//       }else{
//         throw response.data["message"];
//       }
//     }catch(e){
//       rethrow;
//     }
//
//
//   }
//
//
//   static Future<List<Sources>> getSources(String categoryId)async{
//     try{
//       var response = await ApiService.dio.get("top-headlines/sources",queryParameters: {
//         "category":categoryId
//       });
//       if(response.statusCode == 200){
//         var data = SourcesResponse.fromJson(response.data);
//         return data.sources ?? [];
//       }else{
//         throw response.data["message"];
//       }
//     }catch(e){
//       rethrow;
//     }
//   }
//
//
// }