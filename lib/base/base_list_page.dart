import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qn_base_core/base/base_page.dart';
import 'package:qn_base_core/ui/component.dart';
import 'package:qn_base_core/utils/log_utils.dart';

abstract class BaseListPage extends BasePage {
  @override
  BaseListPageState createState() {
    return getState();
  }

  BaseListPageState getState();
}

abstract class BaseListPageState<T extends BaseListPage, D>
    extends BasePageState<BaseListPage> {
  RefreshController controller = RefreshController(initialRefresh: true);
  List<D> list;
  int pageNum = 1;

  //是否已从服务端拉过数据
  bool hasRefreshFromWeb = false;

  //能否刷新
  bool canRefresh = true;

  //能否加载更多
  bool canLoad = true;

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      children: <Widget>[
        buildContentHeader(),
        Expanded(
            child: SmartRefresher(
          header: buildRefreshHeader(),
          footer: buildRefreshFooter(),
          onRefresh: onRefresh,
          onLoading: onLoading,
          controller: controller,
          enablePullUp: canLoad,
          enablePullDown: canRefresh,
          child: buildContent(),
        )),
        buildContentFooter(),
      ],
    );
  }

  @protected
  @mustCallSuper
  void onDestroy() {
    controller.dispose();
    controller = null;
    super.onDestroy();
  }

  ///***********************************上啦下拉加载******************************///
  ///***********************************上啦下拉加载******************************///
  ///
  @protected
  @mustCallSuper
  void onRefresh() async {
    pageNum = 1;
    list?.clear();
    onLoading();
  }

  @protected
  @mustCallSuper
  void onLoading() async {
    try {
      await getList(pageNum, 10);
    } catch (e) {
      L.e(e);
    }
    pageNum += 1;
    hasRefreshFromWeb = true;
    if (mounted) setState(() {});
    controller.refreshCompleted();
    controller.loadComplete();
  }

  Future<dynamic> getList(int pageNum, int pageSize);

  Widget buildItem(BuildContext context, int index);

  ///下拉刷新头部
  @protected
  Widget buildRefreshHeader() {
    return ItemRefreshHeader();
  }

  ///上啦加载更多页面
  @protected
  Widget buildRefreshFooter() {
    return ItemRefreshFooter();
  }

  ///***********************************上啦下拉加载******************************///
  ///***********************************上啦下拉加载******************************///
  //内容除了列表之外的部分
  Widget buildContentHeader() {
    return Container();
  }

  //内容部分
  Widget buildContent() {
    if (list == null || list.length == 0) {
      //列表为空
      if (hasRefreshFromWeb) {
        //没有数据显示页面
        return buildNoDataView();
      } else {
        //默认空页面 一般是刚进入页面
        return buildDefaultEmptyView();
      }
    }
    return ListView.builder(
      itemBuilder: buildItem,
      itemCount: list.length,
    );
  }

  //内容除了列表之外的部分,一般是底部按钮之类的
  Widget buildContentFooter() {
    return Container();
  }
}
