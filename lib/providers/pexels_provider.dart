import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/global/environment-dev.dart';
import 'package:neumorphic_instagram/models/pexel_response.dart';
import 'package:neumorphic_instagram/models/photo.dart';

class PexelsProvider with ChangeNotifier {
  final List<Photo> photos = [];
  final List<Photo> stories = [];
  final dio = Dio();

  late int nextPage;

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
    nextPage = Random().nextInt(100);

    _initData();
  }

  Future<void> _initData() async {
    await getPhotos();
    await getStories();
  }

  Future<List<Photo>> getPhotos() async {
    const url = '/search';

    final query = {
      'query': 'people',
      'per_page': '10',
      'orientation': 'portrait',
      'page': nextPage
    };

    try {
      isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      final response = await dio.request(url,
          queryParameters: query, options: Options(method: 'GET'));

      isLoading = false;

      if (response.statusCode == 200) {
        final pexelsResponse = PexelResponse.fromJson(response.data);
        nextPage = pexelsResponse.page;
        photos.addAll(pexelsResponse.photos);

        return photos;
      } else {
        return photos;
      }
    } catch (exception) {
      throw Error.safeToString(exception);
    }
  }

  Future<List<Photo>> getStories() async {
    const url = '/search';

    final query = {
      'query': 'people',
      'per_page': '10',
      'orientation': 'portrait',
      'page': nextPage
    };

    try {
      isLoading = true;
      final response = await dio.request(url,
          queryParameters: query, options: Options(method: 'GET'));

      isLoading = false;

      if (response.statusCode == 200) {
        final pexelsResponse = PexelResponse.fromJson(response.data);
        nextPage = Random().nextInt(100);

        stories.addAll(pexelsResponse.photos);

        return stories;
      } else {
        return stories;
      }
    } catch (exception) {
      throw Error.safeToString(exception);
    }
  }

  Future<List<Photo>> refreshPhotos() async {
    photos.clear();
    nextPage = Random().nextInt(100);

    return await getPhotos();
  }
}
