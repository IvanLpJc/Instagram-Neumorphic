import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/helpers/helpers.dart';
import 'package:provider/provider.dart';

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
  List<Photo> _photos = [];
  List<Photo> _stories = [];

  final _pexels = PexelsProvider();

  bool openOptions = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    _photos = context.read<PexelsProvider>().photos;
    _stories = context.read<PexelsProvider>().stories;
    setState(() {});

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
    double delta = 50.0;
    setState(() {
      if (openOptions) openOptions = false;
    });

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

  _handleOptions() {
    setState(() {
      openOptions = !openOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final color = Styles.getBaseColor(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: NeumorphicTheme.of(context)!.current!.baseColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              CustomAppBar(
                onTap: () => setState(() {
                  openOptions = !openOptions;
                }),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: _onRefresh,
              ),
              StoriesCarrousel(
                stories: _stories,
              ),
              SliverList.builder(
                itemCount: _photos.length,
                itemBuilder: (_, index) {
                  return Post(photo: _photos[index]);
                },
              ),
            ],
          ),
          Visibility(
            visible: openOptions,
            child: GestureDetector(
              onTap: _handleOptions,
              child: SizedBox(
                width: size.width,
                height: size.height,
              ),
            ),
          ),
          if (openOptions)
            Positioned(
              top: 85,
              left: 18,
              child: Neumorphic(
                child: Container(
                  height: 70,
                  width: 130,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeumorphicText(
                            'Following',
                            style: NeumorphicStyle(color: color),
                            textStyle: NeumorphicTextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          NeumorphicIcon(
                            Icons.people_outline,
                            style: Styles.iconStyle(context),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeumorphicText(
                            'Favorites',
                            style: NeumorphicStyle(color: color),
                            textStyle: NeumorphicTextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          NeumorphicIcon(
                            Icons.star_border_outlined,
                            style: Styles.iconStyle(context),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
