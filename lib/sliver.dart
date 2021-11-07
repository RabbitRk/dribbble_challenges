import 'package:dribbble_challenges/utils/model.dart';
import 'package:flutter/material.dart';

class SliverDemo extends StatefulWidget {
  const SliverDemo({Key? key}) : super(key: key);

  @override
  _SliverDemoState createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo>
    with TickerProviderStateMixin {
  late PageController controller_bg;
  late PageController controller;
  late PageController controller_content;
  late TabController _controller;
  int thisPage = 0;
  int controllerIndex = 0;

  late AnimationController titleController;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0, viewportFraction: 0.8);
    controller_bg = PageController(initialPage: 0);
    controller_content = PageController(initialPage: 0);
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_handleTabSelection);

    titleController = AnimationController(
        duration: const Duration(milliseconds: 320), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      thisPage = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(
      slivers: <Widget>[
         SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          collapsedHeight: 250,
          expandedHeight: 500.0,

          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background:  PageView.builder(
                padEnds: false,
                controller: controller,
                onPageChanged: (index) {
                  titleController.forward();
                  setState(() {
                    controllerIndex = index;
                    controller_bg.animateToPage(index,
                        curve: Curves.easeOut,
                        duration: Duration(milliseconds: 320));
                    controller_content.animateToPage(index,
                        curve: Curves.easeOut,
                        duration: Duration(milliseconds: 320));
                  });
                },
                itemCount: movie_model.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0, 0.5, 0.7],
                                  colors: [
                                    Colors.black,
                                    Colors.transparent.withOpacity(0.3),
                                    Colors.transparent
                                  ],
                                ).createShader(Rect.fromLTRB(
                                    0, 0, rect.width, rect.height));
                              },
                              blendMode: index == controllerIndex
                                  ? BlendMode.dst
                                  : BlendMode.dstIn,
                              child: Image.asset(
                                movie_model[index].poster,
                                fit: BoxFit.cover,
                              ),
                            ),
                            //
                            // Image.asset(
                            //   movie_model[index].poster,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              );
            },
          ),
        ),
      ],
    ),);
  }
}
