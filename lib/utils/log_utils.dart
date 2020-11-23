import 'package:qn_base_core/base/env.dart';

/// Log Util.
class L {
  static const String _TAG_DEF = "qnlog";
  static String TAG = _TAG_DEF;

  static void e(Object object, {String tag}) {
    _printLog(tag,object);
  }

  static void v(Object object, {String tag}) {
    if (Env.isDebug) {
      _printLog(tag,object);
    }
  }
  static void _printLog(String tag,Object object) {
    String _tag = (tag == null || tag.isEmpty) ? TAG : (TAG+tag);
    print("$_tag ${object.toString()}");
    //    while (da.isNotEmpty) {
//      if (da.length > 512) {
//        print("$_tag $stag ${da.substring(0, 512)}");
//        da = da.substring(512, da.length);
//      } else {
//        print("$_tag $stag $da");
//        da = "";
//      }
//    }
  }
}
