import 'package:injectable/injectable.dart';

import 'package:shorebird_example/models/index.dart';
import 'package:shorebird_example/services/http/http_client.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient);

  Future<List<Post>> getPosts() async {
    final response =
        await httpClient.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Post.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
