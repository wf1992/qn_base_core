import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qn_base_core/base/base_page.dart';
import 'package:qn_base_core/ui/component.dart';
import 'package:qn_base_core/utils/log_utils.dart';

abstract class BaseDetailPage extends BasePage {
  @override
  BaseDetailPageState createState() {
    return getState();
  }

  BaseDetailPageState getState();
}

abstract class BaseDetailPageState<T extends BaseDetailPage, D>
    extends BasePageState<BaseDetailPage> {
  RefreshController controller= RefreshController(initialRefresh: true);
  D md;
  //服务端是否没数据
  bool hasRefreshFromWeb = false;
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
              enablePullUp: false,
              enablePullDown: true,
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
    onLoading();
  }

  @protected
  @mustCallSuper
  void onLoading() async {
    try {
      await getDetailTask();
    } catch (e) {
      L.e(e);
    }
    hasRefreshFromWeb = true;
    if (mounted) setState(() {});
    controller.refreshCompleted();
  }

  Future<dynamic> getDetailTask();
  ///内容部分
  Widget buildInfoPart();

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
    if (md == null) {
      //列表为空
      if (hasRefreshFromWeb) {
        //没有数据显示页面
        return buildNoDataView();
      }else{
        //默认空页面 一般是刚进入页面
        return buildDefaultEmptyView();
      }
    }
    return buildInfoPart();
  }

  //内容除了列表之外的部分,一般是底部按钮之类的
  Widget buildContentFooter() {
    return Container();
  }
}
