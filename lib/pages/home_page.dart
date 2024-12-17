import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_panells/widgets/image_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  final Function(bool) afterScrollResult;
  const HomePage({super.key, required this.afterScrollResult});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;
  final ScrollController _scrollController = ScrollController();  

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          //setState(() {
            _isVisible = false;
            widget.afterScrollResult(_isVisible);
          //});
        }
      }
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisible) {
          //setState(() {
            _isVisible = true;
            widget.afterScrollResult(_isVisible);
          //});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                //backgroundColor: Colors.white,
                //foregroundColor: Colors.black,
                snap: true,
                centerTitle: true,
                title: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  //child: const Text('Home'),
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                  ],
                  indicatorColor: Colors.red,
                  indicatorWeight: 4,
                  labelStyle: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  unselectedLabelColor: Colors.grey,
                  /* indicator: BoxDecoration(
                    color: Colors.black,
                  ), */

                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return ImageTile(
                    index: index,
                    imageSource: 'https://picsum.photos/500/500?random=$index',
                    //extent: (index % 5 + 1) * 100,
                    extent: ( index % 2 ) == 0 ? 300 : 150,
                  );
                },
              ),
              const SizedBox(),
              const SizedBox(),
            ],

          ),
        ),
      ),
    );
  }
}