import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/global/environment.dart';
import 'package:neumorphic_instagram/models/pexel_response.dart';
import 'package:neumorphic_instagram/models/photo.dart';

class PexelsProvider with ChangeNotifier {
  final List<Photo> photos = [];
  final dio = Dio();

  late int currentPage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PexelsProvider() {
    dio.options.baseUrl = Environment.baseUrl;
    dio.options.headers = {
      'Authorization': Environment.apiKey,
    };
    currentPage = Random().nextInt(100);

    _initData();
  }

  _initData() async {
    await getPhotos();
  }

  Future<List<Photo>> getPhotos() async {
    const url = '/search';

    final query = {
      'query': 'people',
      'per_page': '10',
      'orientation': 'portrait',
      'page': currentPage + 1
    };

    try {
      isLoading = false;
      final response = await dio.request(url,
          queryParameters: query, options: Options(method: 'GET'));

      isLoading = false;

      if (response.statusCode == 200) {
        final pexelsResponse = PexelResponse.fromJson(response.data);
        currentPage = pexelsResponse.page;
        photos.addAll(pexelsResponse.photos);

        return photos;
      } else {
        return photos;
      }
    } catch (exception) {
      throw Error.safeToString(exception);
    }
  }

  Future<List<Photo>> refreshPhotos() async {
    photos.clear();
    currentPage = Random().nextInt(100);

    return await getPhotos();
  }
}
