import 'package:flutter/material.dart';
import 'package:qn_base_core/base/base_common_page.dart';
import 'package:qn_base_core/ui/component.dart';

abstract class BaseTabPage extends BaseCommonPage {
  @override
  BaseCommonPageState createState() {
    return getState();
  }

  BaseCommonPageState getState();
}

class TabTitle {
  String title;
  int id;

  TabTitle( this.title,this.id);
}

abstract class BaseTabPageState extends BaseCommonPageState
    with SingleTickerProviderStateMixin {
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  List<TabTitle> tabList;
  var currentPage = 0;
  var isPageCanChanged = true;

  List<Widget> _allPages;

  @override
  @mustCallSuper
  void init() {
    // TODO: implement init
    tabList = getTabTitle();
    _allPages = getTabPage();
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {
      //TabBar的监听
      if (mTabController.indexIsChanging) {
        //判断TabBar是否切换
        onPageChange(mTabController.index, p: mPageController);
      }
    });
  }
  ///tab页切换回调
  onPageChange(int index, {PageController p, TabController t}) async {
    if (mounted) setState(() {});
    if (p != null) {
      //判断是哪一个切换
      isPageCanChanged = false;
      await mPageController?.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      mTabController?.animateTo(index); //切换Tabbar
    }
  }

  ///返回一个tab title list 用于创建tab bar
  List<TabTitle> getTabTitle();
  ///返回一个page list 注意长度和tab title长度一致
  List<Widget> getTabPage();

  @override
  void dispose() {
    super.dispose();
    mTabController?.dispose();
  }

  @override
  Widget buildContent() => Column(
        children: <Widget>[
          buildTabBar(),
          Expanded(
            child: PageView.builder(
              itemCount: tabList.length,
              onPageChanged: (index) {
                if (isPageCanChanged) {
                  onPageChange(index);
                }
              },
              controller: mPageController,
              itemBuilder: (BuildContext context, int index) {
                return _allPages[index];
              },
            ),
          )
        ],
      );

  Widget buildTabBar() {
    return ItemTabBar(
        mTabController,
        tabList.map((item) {
          return Tab(
            text: item.title,
          );
        }).toList());
  }
}
