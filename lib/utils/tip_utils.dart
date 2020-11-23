
//各种提醒窗口
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qn_base_core/base/env.dart';
import 'package:qn_base_core/ui/ui.dart';
import 'package:qn_base_core/utils/nav_utils.dart';

class Tip {
  //短时间提醒

  static void s(String message, {int duration}) {
    EasyLoading.showInfo(message,
        duration: Duration(milliseconds: duration == null ? 1000 : duration));
  }
  //成功
  static void ok(String message, {int duration}) {
    EasyLoading.showSuccess(message,
        duration: Duration(milliseconds: duration == null ? 1000 : duration));
  }
  //失败
  static void f(String message, {int duration}) {
    EasyLoading.showError(message,
        duration: Duration(milliseconds: duration == null ? 2000 : duration));
  }
  //加载中
  static void loading({String message}) {
    EasyLoading.show(status: message == null ? "加载中..." : message);
  }
  //手动隐藏
  static dismiss() {
    EasyLoading.dismiss();
  }
  //进度条
  static p(double value, {status}) {
    EasyLoading.showProgress(value, status: status);
  }
  //alert弹窗
  static a(context,
      {String title,
        String confirmStr = "确认",
        String cancelStr = "取消",
        callback,
        bool hasCancel = true,
        cancelCallBack}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('温馨提示'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(title),
              ],
            ),
          ),
          actions: <Widget>[
            hasCancel
                ? FlatButton(
              child: Text(cancelStr),
              onPressed: () {
                N.back(context);
                if (cancelCallBack != null) cancelCallBack();
              },
            )
                : Container(),
            FlatButton(
              child: Text(confirmStr),
              onPressed: () {
                Navigator.maybePop(context);
                if (callback != null) callback();
              },
            ),
          ],
        );
      },
    );
  }


  ///弹窗显示提醒
  static showWidget(
      context,
      Widget content, {
        callback,
        String tips = "温馨提示",
        String confirmStr = "确认",
        String cancelStr = "取消",
        bool hasCancel = true,
      }) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tips,
            style: UI.tx14_33,
          ),
          content: SingleChildScrollView(
            child: content,
          ),
          actions: <Widget>[
            hasCancel
                ? FlatButton(
              child: Text(cancelStr),
              onPressed: () {
                N.back(context);
              },
            )
                : Container(),
            FlatButton(
              child: Text(confirmStr),
              onPressed: () {
                Navigator.maybePop(context);
                if (callback != null) callback();
              },
            ),
          ],
        );
      },
    );
  }

  ///弹窗显示选择
  static void showBottomWidget(BuildContext context, Widget widget) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(builder: (context1, setBottomSheetState) {
            return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              child: widget,
            );
          });
        });
  }
}