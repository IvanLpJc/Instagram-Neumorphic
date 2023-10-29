import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'package:neumorphic_instagram/models/photo.dart';
import 'package:neumorphic_instagram/providers/pexels_provider.dart';
import 'package:neumorphic_instagram/ui/widgets/widgets.dart';

class FeedPage extends StatefulWidget {
  static const String route = 'feed_page';

  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final _scrollController = ScrollController();
  double _prevScrollPos = 0.0;
  final List<Photo> _photos = [];

  final _pexels = PexelsProvider();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    final response = await _pexels.refreshPhotos();
    _photos.clear();
    _photos.insertAll(0, response);
    setState(() {});

    _refreshController.refreshCompleted();
  }

  _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScrollPos = _scrollController.position.pixels;
    double delta = 100.0;

    if (maxScroll - currentScrollPos <= delta &&
        _prevScrollPos - currentScrollPos < 0) {
      // _pexels.getPhotos();
      setState(() {});
    }

    _prevScrollPos = currentScrollPos;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_photos.isEmpty) {
      _onRefresh();
    }

    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const CustomAppBar(),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          const StoriesCarrousel(),
          SliverList.builder(
            itemCount: _photos.length,
            itemBuilder: (_, index) {
              return Post(photo: _photos[index]);
            },
          ),
        ],
      ),
    );
  }
}
