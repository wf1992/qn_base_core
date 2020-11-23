import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qn_base_core/ui/ui.dart';

///默认空数据页面
class ItemNoDataView extends StatelessWidget {
  final String tips;
  final callback;

  const ItemNoDataView({Key key, this.tips = "暂无数据", this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImgAssets(
                    name: "ic_empty.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                  Text(
                    tips,
                    textAlign: TextAlign.center,
                    style: UI.tx14_99,
                  )
                ],
              ),
            ),
            onTap: () {
              try {
                if (callback != null) callback();
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }
}

///读取assets图片组件
class ImgAssets extends StatelessWidget {
  const ImgAssets(
      {Key key,
      @required this.name,
      this.width,
      this.height,
      this.fit: BoxFit.contain})
      : super(key: key);
  final String name;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset(
      'assets/images/$name',
      width: width,
      height: height,
      fit: fit,
    );
  }
}

///appbar
// ignore: must_be_immutable
class ItemAppBar extends AppBar {
  final String titleStr;
  final Color statusColor;
  final Color txColor;
  final List<Widget> actions;
  var leftClick;
  final bool hasLeading;
  final bool hasDivider;

  ItemAppBar(
      {Key key,
      this.statusColor,
      this.titleStr,
      this.actions,
      this.leftClick,
      this.hasDivider = true, //是否有分割线
      this.txColor, //标题颜色,如果有颜色 则显示颜色,否则使用默认颜色
      this.hasLeading = true})
      : super(
          key: key,
          elevation: hasDivider ? 1 : 0,
          actions: actions,
          centerTitle: true,
          backgroundColor: statusColor != null ? statusColor : UI.clFF,
          title: Text(titleStr == null ? "标题" : titleStr,
              style: TextStyle(
                  fontSize: UI.font_17,
                  color: txColor != null
                      ? txColor
                      : (statusColor != null ? UI.clFF : UI.cl33))),
          leading: hasLeading
              ? IconButton(
                  icon: ImgAssets(
                    name: txColor != null
                        ? "ic_arrow_left.png"
                        : (statusColor != null
                            ? "ic_arrow_left_white.png"
                            : "ic_arrow_left.png"),
                    width: UI.dp24,
                    height: UI.dp24,
                  ),
                  onPressed: () {
                    if (leftClick != null) {
                      leftClick();
                    }
                  })
              : null,
        );
}



///TabBar
// ignore: non_constant_identifier_names
Widget ItemTabBar(TabController mTabController, List<Widget> tabs) {
  return Container(
    color: UI.clFF,
    width: double.infinity,
    child: TabBar(
      isScrollable: true,
      //是否可以滚动
      controller: mTabController,
      indicatorPadding: EdgeInsets.only(top:UI.dp8),
      indicatorColor: UI.clMain,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: UI.cl33,
      unselectedLabelColor: UI.clFade,
      unselectedLabelStyle: UI.tx14_99,
      labelStyle: UI.tx14_33,
      tabs: tabs,
    ),
  );
}

///下拉头部尾部
class ItemRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClassicHeader(
      height: UI.dp48,
      releaseText: '松手刷新',
      refreshingText: '刷新中',
      completeText: '刷新完成',
      failedText: '刷新失败',
      idleText: '刷新',
    );
  }
}
///下拉头部尾部
class ItemRefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClassicFooter(
      loadingText: "加载中...",
      noDataText: "已经到底了",
      canLoadingText: "松手加载",
      idleText: "加载更多",
      failedText: "加载失败",
      loadStyle: LoadStyle.ShowAlways,
    );
  }
}
