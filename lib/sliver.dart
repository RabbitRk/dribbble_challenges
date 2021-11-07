import 'package:dribbble_challenges/utils/model.dart';
import 'package:flutter/material.dart';

class SliverDemo extends StatefulWidget {
  const SliverDemo({Key? key}) : super(key: key);

  @override
  _SliverDemoState createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> with TickerProviderStateMixin {
  var top = 0.0;
  late ScrollController _scrollController;
  late Widget _widget;

  @override
  void initState() {
    super.initState();
    _widget = poster1();
    _scrollController = ScrollController()
      ..addListener(
        () => _isAppBarExpanded
            ? widget == poster1() ?setState(() {
                _widget = poster2();
              }):null
            : setState(() {
                _widget = poster1();
              }),
      );
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 600.0,
              collapsedHeight: 400,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              title: buildAppBar(),
              flexibleSpace: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                  child: _widget)),
        ];
      },
      body: ListView.builder(

        itemCount: 10,
        itemBuilder: (context, index) {
          return Text("List Item: " + index.toString());
        },
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
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
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

  Widget poster1() {
    return Image.asset(
      'assets/posters/poster1.jpg',
      fit: BoxFit.cover,
    );
  }

  Widget poster2() {
    return Image.asset(
      'assets/posters/poster2.jpg',
      fit: BoxFit.cover,
    );
  }

// Widget build(BuildContext context) {
//   return Scaffold(
//     body: NestedScrollView(
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return <Widget>[
//           SliverAppBar(
//             expandedHeight: 400.0,
//             collapsedHeight: 250,
//             pinned: true,
//             flexibleSpace: Image.asset(
//               "assets/posters/poster1.jpg",
//               fit: BoxFit.cover,
//             ),
//           ),
//         ];
//       },
//       body: ListView.builder(
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 80,
//             color: Colors.primaries[index % Colors.primaries.length],
//             alignment: Alignment.center,
//             child: Text(
//               'Item : $index',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//           );
//         },
//         itemCount: 20,
//       ),
//     ),
//   );
// }
}
