import 'package:flutter/material.dart';
import 'package:qn_base_core/ui/component.dart';
import 'package:qn_base_core/utils/class_utils.dart';
import 'package:qn_base_core/utils/log_utils.dart';
import 'package:qn_base_core/utils/nav_utils.dart';
import 'package:qn_base_core/utils/tip_utils.dart';

abstract class BasePage extends StatefulWidget {
  @override
  BasePageState createState() {
    return getState();
  }

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  String tag = "BasePageState_";
  bool isInit = false; //是否初始化数据

  ///***********************************生命周期******************************///
  ///***********************************生命周期******************************///
  @override
  void initState() {
    L.v(tag + "initState\n");
    tag = ClassUtils.getClassName(context) + "_";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    L.v(tag + "didChangeDependencies\n");
    if (!isInit) {
      init();
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    L.v(tag + "didUpdateWidget\n");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    L.v(tag + "reassemble\n");
    super.reassemble();
  }

  @override
  void deactivate() {
    L.v(tag + "deactivate\n");
    super.deactivate();
  }

  @override
  void dispose() {
    L.v(tag + "dispose\n");
    onDestroy();
    super.dispose();
  }

  @protected
  @mustCallSuper
  void onDestroy() {
    L.v(tag + "onDestroy\n");
  }

  @override
  Widget build(BuildContext context) {
    L.v(tag + "build ");
    try {
      return Scaffold(
        appBar: needBar() ? buildAppBar() : null,
        body: buildBody(context),
      );
    } catch (e) {
      return Container();
    }
  }

  ///***********************************生命周期******************************///
  ///***********************************生命周期******************************///

  ///***********************************内容绘制******************************///
  ///***********************************内容绘制******************************///

  ///是否需要appBar,默认true
  bool needBar() {
    return true;
  }

  @protected
  AppBar buildAppBar() {
    return ItemAppBar(
      titleStr: getTitleStr(),
      actions: buildActions(),
      leftClick: () {
        N.back(context);
      },
    );
  }

  ///右侧按钮
  @protected
  List<Widget> buildActions() {
    return [];
  }

  ///页面标题
  @protected
  String getTitleStr();

  ///初始化数据,一般在这里获取传参
  @protected
  void init();

  ///body部分
  @protected
  Widget buildBody(BuildContext context);

  ///***********************************内容绘制******************************///
  ///***********************************内容绘制******************************///

  ///暂无数据显示页面
  @protected
  Widget buildNoDataView() {
    return ItemNoDataView();
  }

  @protected
  Widget buildDefaultEmptyView() {
    return Container();
  }

  ///***********************************公共方法******************************///
  ///***********************************公共方法******************************///
  //获取传参,一般在init中使用
  @protected
  dynamic getArg(String key) {
    try {
      Map map = ModalRoute.of(context).settings.arguments as Map;
      if (map != null && map.containsKey(key)) {
        return map[key];
      }
      map = null;
    } catch (e) {
      L.e(e);
    }
    return null;
  }

  //toast提醒
  @protected
  void t(String message) {
    Tip.s(message);
  }

  ///***********************************公共方法******************************///
  ///***********************************公共方法******************************///`

}
