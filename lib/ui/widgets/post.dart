import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/helpers/helpers.dart';
import 'package:neumorphic_instagram/models/photo.dart';
import 'package:provider/provider.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required Photo photo,
  }) : _photo = photo;

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => _PostProvider(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: width,
        child: Neumorphic(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _Photo(photo: _photo, width: width),
                  Positioned(
                    top: 4,
                    child: _TopBar(width: width, photo: _photo),
                  ),
                ],
              ),
              _Description(photo: _photo)
            ],
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatefulWidget {
  const _Photo({
    required Photo photo,
    required this.width,
  }) : _photo = photo;

  final Photo _photo;
  final double width;

  @override
  State<_Photo> createState() => _PhotoState();
}

class _PhotoState extends State<_Photo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        final provider = Provider.of<_PostProvider>(context, listen: false);
        if (provider.isLiked == CrossFadeState.showFirst) {
          provider.like();
        }
        _animationController.forward();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          FancyShimmerImage(
            imageUrl: widget._photo.url,
            height: 546,
            boxFit: BoxFit.fill,
            width: widget.width,
          ),
          ScaleTransition(
            scale: _animation,
            child: NeumorphicIcon(
              Icons.favorite,
              size: 80,
              style: NeumorphicStyle(color: Styles.getBaseColor(context)),
            ),
          ),
          ScaleTransition(
            scale: _animation,
            child: NeumorphicIcon(
              Icons.favorite_outline_outlined,
              size: 70,
              style: Styles.iconStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.width,
    required Photo photo,
  }) : _photo = photo;

  final double width;
  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    final color = Styles.getFontColorFromReference(_photo.avgColor);
    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            margin: const EdgeInsets.only(left: 25),
            style: Styles.avatarStyle(color: color),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: color,
              child: FancyShimmerImage(
                imageUrl: _photo.url,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          NeumorphicText(
            _photo.photographer,
            style: NeumorphicStyle(
              color: color,
            ),
            textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          NeumorphicButton(
            style: const NeumorphicStyle(color: Colors.transparent),
            child: NeumorphicIcon(
              Icons.more_vert_rounded,
              size: 25,
              style: NeumorphicStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatefulWidget {
  const _Description({
    required Photo photo,
  }) : _photo = photo;

  final Photo _photo;

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  int? maxLines;
  TextOverflow overflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final color = Styles.getBaseColor(context);

    return InkWell(
      onTap: () => setState(() {
        if (maxLines == null) {
          maxLines = 1;
          overflow = TextOverflow.ellipsis;
        } else {
          maxLines = null;
          overflow = TextOverflow.clip;
        }
      }),
      child: SizedBox(
        width: width,
        child: Neumorphic(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Actions(width: width),
              const _Likes(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 8),
                child: RichText(
                  maxLines: maxLines,
                  overflow: overflow,
                  text: TextSpan(
                    text: '${widget._photo.photographer} ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    children: [
                      TextSpan(
                          text: widget._photo.alt,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, color: color))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 8),
                child: NeumorphicText(
                  'View comments',
                  style: NeumorphicStyle(color: color.withOpacity(0.7)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 8),
                child: Row(
                  children: [
                    Neumorphic(
                      style: Styles.avatarStyle(color: color),
                      child: const CircleAvatar(
                        radius: 12,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NeumorphicText(
                      'Add a comment...',
                      style: NeumorphicStyle(color: color.withOpacity(0.7)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Actions extends StatefulWidget {
  const _Actions({
    required this.width,
  });

  final double width;

  @override
  State<_Actions> createState() => _ActionsState();
}

class _ActionsState extends State<_Actions> {
  @override
  Widget build(BuildContext context) {
    final color = Styles.getBaseColor(context);
    return Container(
      width: widget.width,
      padding: const EdgeInsets.only(left: 10, top: 5, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: Provider.of<_PostProvider>(context, listen: false).like,
            child: AnimatedCrossFade(
              sizeCurve: Curves.elasticOut,
              firstChild: NeumorphicIcon(
                Icons.favorite_border_outlined,
                size: 28,
                style: NeumorphicStyle(color: color),
              ),
              secondChild: NeumorphicIcon(
                Icons.favorite,
                size: 28,
                style: NeumorphicStyle(color: color),
              ),
              crossFadeState: Provider.of<_PostProvider>(context).isLiked,
              duration: const Duration(milliseconds: 100),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          NeumorphicIcon(
            Icons.comment_outlined,
            size: 28,
            style: NeumorphicStyle(color: color),
          ),
          const SizedBox(
            width: 10,
          ),
          NeumorphicIcon(
            Icons.send_outlined,
            size: 28,
            style: NeumorphicStyle(color: color),
          ),
          const Spacer(),
          NeumorphicIcon(
            Icons.save_outlined,
            size: 28,
            style: NeumorphicStyle(color: color),
          ),
        ],
      ),
    );
  }
}

class _Likes extends StatelessWidget {
  const _Likes({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Styles.getBaseColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: NeumorphicText(
        '6,485 likes',
        style: NeumorphicStyle(color: color),
        textStyle: NeumorphicTextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class _PostProvider with ChangeNotifier {
  CrossFadeState _isLiked = CrossFadeState.showFirst;

  CrossFadeState get isLiked => _isLiked;

  like() {
    if (_isLiked == CrossFadeState.showFirst) {
      _isLiked = CrossFadeState.showSecond;
    } else {
      _isLiked = CrossFadeState.showFirst;
    }
    notifyListeners();
  }
}
