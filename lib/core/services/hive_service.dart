import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<BoxCollection> getRef() async {
    var dir = await getApplicationCacheDirectory();
    final collection = await BoxCollection.open(
      'NewsApp', // Name of your database
      {'news'}, // Names of your boxes
      path: dir.path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    return collection;
  }
}
