import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qn_base_core/base/base_page.dart';

abstract class BaseCommonPage extends BasePage {
  @override
  BaseCommonPageState createState() {
    return getState();
  }

  BaseCommonPageState getState();
}

abstract class BaseCommonPageState extends BasePageState<BaseCommonPage> {
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      children: <Widget>[
        buildContentHeader(),
        Expanded(
          child: buildContent(),
        ),
        buildContentFooter(),
      ],
    );
  }

  //内容除了列表之外的部分
  Widget buildContentHeader() {
    return Container();
  }

  //内容部分
  Widget buildContent();

  //内容除了列表之外的部分,一般是底部按钮之类的
  Widget buildContentFooter() {
    return Container();
  }
}
