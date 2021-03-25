import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Created by minh.tran on 25/03/2021.

List<String> source = [
  'https://dummyimage.com/1200x400/000/fff',
];

class BannerWidget extends StatefulWidget {
  const BannerWidget({this.aspectRatio});

  final double aspectRatio;

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  PageController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 1),(){
        setState(() {

        });
      });
    });
  }

  bool a = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: LayoutBuilder(builder: (context, constraint) {
        final maxWidth = constraint.maxWidth;
        final maxWidth2 = maxWidth - 48;
        final maxHeight = maxWidth / widget.aspectRatio;
        final maxHeight2 = maxWidth2 / widget.aspectRatio;
        final ratioFinal = maxWidth / maxHeight2;
        print('ratio-final:${ratioFinal}');
        print('constraint-2:${maxWidth},${maxHeight}');
        if (controller == null) {
          controller = PageController(
            initialPage: 250,
            viewportFraction: maxWidth2 / maxWidth,
          );
          // controller.addListener(() {
          //   if(controller.position.haveDimensions && a){
          //     a = false;
          //     setState(() {
          //
          //     });
          //   }
          // });
        }
        return AspectRatio(
          aspectRatio: ratioFinal,
          child: PageView.builder(
              controller: controller,
              itemCount: 500,
              clipBehavior: Clip.hardEdge,
              itemBuilder: (context, index) {
                if(controller.position.haveDimensions) {
                  // try {
                  //   print(controller?.page);
                  return ItemWidget(controller, index);
                  // }catch(e){
                  //   print('error:${e}');
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
                return ItemWidget(controller, index);
              }),
        );
      }),
    );
  }
}

class ItemWidget extends StatefulWidget {
  ItemWidget(this.controller, this.index);

  PageController controller;
  int index;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  double _page = 0.0;
  int _index = 0;
  PageController _controller;

  // 0: left,1:center,2:right
  int _position;

  int get position => _position;

  set position(int newValue) {
    if (_position == null) {
      _position = newValue;
    }
  }

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {

      });
    });
    _controller = widget.controller;
    // print('first position:${_controller.position}');
    _index = widget.index;
    // TODO: implement initState
    if (_index < _controller.page) {
      _page = _controller.page - _index;
    } else if (_index > _controller.page) {
      _page = _index - _controller.page;
    } else {}
    int currentPage =
        ((_controller.offset / _controller.position.maxScrollExtent) * 500)
            .toInt();
    if (currentPage == _index) {
      position = 1;
    } else if (currentPage > _index) {
      position = 0;
    } else {
      position = 2;
    }
    print('page:$_index,currentPage:${currentPage},_index:${_index}');

    _controller.addListener(() {
      print('offset:${_controller.offset},index:${_index}');
      int currentPage =
          ((_controller.offset / _controller.position.maxScrollExtent) * 500)
              .toInt();
      print('currentPage:${currentPage}');

      int _hihiPage = (currentPage).toInt();
      if (_hihiPage != _currentPage) {
        _currentPage = _hihiPage;
        _position = null;
      }
      if (!mounted) {
        return;
      }
      if (_index < _controller.page) {
        _page = _controller.page - _index;
      } else if (_index > _controller.page) {
        _page = _index - _controller.page;
      } else {}
      if (currentPage == _index) {
        position = 1;
      } else if (currentPage > _index) {
        position = 0;
      } else {
        position = 2;
      }
      print('index:${_index}/page:${_page}');
      setState(() {});
    });
  }

  Alignment _getAlignment() {
    if (position == 1) {
      return Alignment.center;
    } else if (position == 0) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  EdgeInsets _getPadding() {
    if (position == 1) {
      print('_page is:${_page}');
      return EdgeInsets.all(8 * _page);
    } else if (position == 0) {
      return EdgeInsets.only(top: 8 * _page, bottom: 8 * _page, right: 8);
    } else {
      return EdgeInsets.only(top: 8 * _page, bottom: 8 * _page, left: 8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedAlign(
        curve: Curves.fastOutSlowIn,
        alignment: _getAlignment(),
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: _getPadding(),
          child: LayoutBuilder(builder: (context, constraint) {
            print('constraint:${constraint.maxWidth},${constraint.maxHeight}');
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: source[_index % source.length],
                fit: BoxFit.fitWidth,
              ),
            );
          }),
        ),
      ),
      // _buildLabel(),
      // Positioned(
      //   left: 0,
      //   right: 0,
      //   bottom: 0,
      //   child: Text(
      //     _index.toString(),
      //     style: TextStyle(color: Colors.white),
      //   ),
      // )
    );
  }

  Widget _buildLabel() {
    if (position == 0) {
      return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Row(
          children: [
            Text(
              'left',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Text(
              'left',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    if (position == 1) {
      return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Row(
          children: [
            Text(
              'center',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Text(
              'center',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    if (position == 2) {
      return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Row(
          children: [
            Text(
              'right',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Text(
              'right',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
  }
}
