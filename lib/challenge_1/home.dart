import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:dribbble_challenges/utils/model.dart';
import 'package:dribbble_challenges/utils/widget.dart';
import 'package:flutter/material.dart';

import '_button_tab.dart';

class MovieOrderHome extends StatefulWidget {
  const MovieOrderHome({Key? key}) : super(key: key);

  @override
  _MovieOrderHomeState createState() => _MovieOrderHomeState();
}

class _MovieOrderHomeState extends State<MovieOrderHome>
    with TickerProviderStateMixin {
  late PageController controller_bg;
  late PageController controller;
  late PageController controller_content;
  late TabController _controller;
  int thisPage = 0;
  int controllerIndex = 0;
  double scroll = 1.0;

  late AnimationController titleController;

  ScrollController _scrollController = ScrollController();

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

    _scrollController.addListener(_handleMini);
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

  void _handleMini() {
    // print(_scrollController.offset);
    print(_scrollController.offset / 100);
    setState(() {
      if ((_scrollController.offset / 100) <= 0.4) {
        scroll = _scrollController.offset / 100;
        controller = PageController(
            initialPage: controllerIndex,
            viewportFraction: 0.8 - scroll);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: buildAppBar(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              PageView.builder(
                  physics: ClampingScrollPhysics(),
                  controller: controller_bg,
                  itemCount: movie_model.length,
                  itemBuilder: (context, index) {
                    return ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.multiply,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(movie_model[index].poster),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                    );
                  }),
              SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.65- scroll),
                        child: PageView.builder(
                            padEnds: false,
                            controller: controller,
                            physics: scroll > 0.3 ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                controllerIndex = index;
                                controller_bg.animateToPage(index,
                                    curve: Curves.easeOut,
                                    duration: Duration(milliseconds: 320));
                                controller_content.animateToPage(index,
                                    curve: Curves.easeOut,
                                    duration: Duration(milliseconds: 320));
                              });

                              titleController.forward();
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
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: ShaderMask(
                                          shaderCallback: (rect) {
                                            return LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              stops: [0, 0.5, 0.7],
                                              colors: [
                                                Colors.black,
                                                Colors.black
                                                    .withOpacity(0.3),
                                                scroll > 0.3 ? Colors.black :
                                                Colors.black.withOpacity(0.0)

                                                // Colors.transparent
                                                //     .withOpacity(0.3),
                                                // Colors.transparent
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
                      //Movie Detail
                      SizedBox(
                        height: 90,
                        child: PageView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            controller: controller_content,
                            itemCount: movie_model.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 4, right: 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: const Text(
                                                "IMDb",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          spacer(8),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              spacer(2),
                                              Text(movie_model[index].rating,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          )
                                        ],
                                      ),
                                      spacer(16),
                                      Text(movie_model[index].title,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      spacer(8),
                                      Text(movie_model[index].description,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                )),
                      ),
                      //Movie Tab
                      Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: ButtonsTabBar(
                          radius: 10,
                          buttonMargin: EdgeInsets.zero,
                          controller: _controller,
                          physics: const ClampingScrollPhysics(),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          unselectedBackgroundColor: Colors.white,
                          unselectedLabelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.w700),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          tabs: const [
                            Tab(
                              text: "Details",
                            ),
                            Tab(
                              text: "Showtimes",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Story",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                            spacer(8.0),
                            Text(
                              movie_model[controllerIndex].story,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  height: 1.6),
                            ),
                            spacer(36.0),
                            Text(
                              "Characters",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 96,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  buildRowItem(),
                                  buildRowItem(),
                                  buildRowItem(),
                                  buildRowItem(),
                                  buildRowItem(),
                                ],
                              ),
                            ),
                            spacer(36.0),
                            Text(
                              "Trailers and stills",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                            spacer(8.0),
                            SizedBox(
                              height: 96,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  buildRowItem2(),
                                  buildRowItem2(),
                                  buildRowItem2(),
                                  buildRowItem2(),
                                  buildRowItem2(),
                                ],
                              ),
                            ),
                            spacer(24)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular Now",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700),
        ),
        IconButton(
            onPressed: () {
              print("data");
              // setState(() {
              //   controller = PageController(
              //       initialPage: controllerIndex,
              //       viewportFraction: 0.8);
              // });
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            )),
        // Text("Notifications",
        //     style: TextStyle(
        //         color: Colors.white70,
        //         fontSize: 20,
        //         fontWeight: FontWeight.w700))
      ],
    );
  }

  Container buildRowItem2() {
    return Container(
      height: 80,
      width: 160,
        margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(8)),
    );
  }

  Row buildRowItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(right: 8.0)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tony Stark",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            spacer(8),
            Text(
              "Robert Downey Jr.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
        spacer(8.0)
      ],
    );
  }
}
/*
 PageView.builder(
  physics: NeverScrollableScrollPhysics(),
  controller: controller_bg,
  itemCount: movie_model.length,
  itemBuilder: (context, index) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
          ],
        ).createShader(
            Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.multiply,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(movie_model[index].poster),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }),




   Column(
          children: [
            spacer(48),
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        print("data");
                        setState(() {
                          controller = PageController(
                              initialPage: controllerIndex,
                              viewportFraction: 0.8);
                        });
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                  // Text("Notifications",
                  //     style: TextStyle(
                  //         color: Colors.white70,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w700))
                ],
              ),
            ),
            //Movie Poster
            Expanded(
              child: PageView.builder(
                  padEnds: false,
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      controllerIndex = index;
                      // controller_bg.animateToPage(index,
                      //     curve: Curves.easeOut,
                      //     duration: Duration(milliseconds: 320));
                      controller_content.animateToPage(index,
                          curve: Curves.easeOut,
                          duration: Duration(milliseconds: 320));
                    });

                    titleController.forward();

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
            //Movie Detail
            SizedBox(
              height: 90,
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller_content,
                  itemCount: movie_model.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 4, right: 4),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(4.0),
                                    border: Border.all(
                                        color: Colors.white)),
                                child: const Text(
                                  "IMDb",
                                  style: TextStyle(
                                      color: Colors.white),
                                )),
                            spacer(8),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                spacer(2),
                                Text(movie_model[index].rating,
                                    style: TextStyle(
                                        color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                        spacer(16),
                        Text(movie_model[index].title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        spacer(8),
                        Text(movie_model[index].description,
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )),
            ),
            //Movie Tab
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: ButtonsTabBar(
                radius: 10,
                buttonMargin: EdgeInsets.zero,
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                unselectedBackgroundColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w700),
                labelStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                tabs: const [
                  Tab(
                    text: "Details",
                  ),
                  Tab(
                    text: "Showtimes",
                  ),
                ],
              ),
            ),
            FlutterLogo(),
            FlutterLogo(),
            FlutterLogo(),
            FlutterLogo(),
            FlutterLogo(),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       Text("movie_model", style: TextStyle(color: Colors.white)),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //       FlutterLogo(),
            //     ],
            //   ),
            // ),
          ],
        )
* */
