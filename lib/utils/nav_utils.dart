import 'package:flutter/material.dart';
import 'package:qn_base_core/utils/tip_utils.dart';

class N {
  ///pageName不为空则，直接返回指定页面(如果存在的话)
  ///pageName为空，则返回上一个页面
  static void back(BuildContext context, {String untilPageName, result}) {
    if (untilPageName == null) {
      Tip.dismiss();
      //直接返回
      Navigator.pop(context, result);
    } else {
      //直到返回
      Navigator.popUntil(
        context,
        ModalRoute.withName(
          untilPageName,
        ),
      );
    }
  }
}
