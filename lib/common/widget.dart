import 'package:barber/constant/appconstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget text(String text,
    {var fontSize = 12.0,
      textColor = const Color(0xffffffff),
      var fontFamily = fontRegular,
      var isCentered = false,
      var isEnd = false,
      var maxLine = 2,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false,
      var overFlow = false,
      var decoration=false,}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : isEnd ? TextAlign.end : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration: decoration?TextDecoration.underline:TextDecoration.none
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 10.0,
      Color color = Colors.transparent,
      Color bgColor = Colors.white,
      var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      boxShadow: showShadow
      ? [BoxShadow(color: GreyColor.withOpacity(0.1), blurRadius: 4, spreadRadius: 1)]
          : [BoxShadow(color: Colors.transparent)],
  border: Border.all(color: color),
  borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}
changeStatusBarColor(Color color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: color, // navigation bar color
    statusBarColor: color,
    statusBarIconBrightness: Brightness.dark// status bar color
  ));
}

BoxDecoration boxDecoration2(
    {double radius = 10.0,
      Color color = Colors.transparent,
      Color bgColor = Colors.white,
      var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      boxShadow: showShadow
      ? [BoxShadow(color: AppTextColorSecondary, blurRadius: 6, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
  border: Border.all(color: color),
  borderRadius: BorderRadius.only(
  bottomLeft: Radius.circular(radius),
  bottomRight: Radius.circular(radius)),
  );
}

class NewButton extends StatefulWidget {
  var textContent;
  bool selected=false;
  //   var icon;
  VoidCallback onPressed;

  NewButton( {
    @required this.textContent,
    required this.onPressed,
    required this.selected,
    //   @required this.icon,
  });

  @override
  quizButtonState createState() => quizButtonState();
}

class quizButtonState extends State<NewButton> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
          width: !widget.selected?width:width*0.15,
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
            boxShadow:  [BoxShadow(color: AppTextColorSecondary.withOpacity(0.15), blurRadius: 1, spreadRadius: 1)],
            gradient: new LinearGradient(
              colors: [
                !widget.selected?ColorPrimary:Colors.white,
                !widget.selected?ColorPrimary:Colors.white,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              /*  begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),*/
              stops: [0.0, 1.0],),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),

          ),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: !widget.selected?Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: text(widget.textContent, textColor: Colors.white, fontFamily: fontMedium, textAllCaps: false,fontSize: 14.0),
              ),
            ],
          ):CircularProgressIndicator(color: ColorPrimary,)),
    );
  }
}
Widget commonCacheImageWidget(String? url, double height, {double? width, BoxFit? fit}) {
  if (url.toString().startsWith('http')) {
    return CachedNetworkImage(
      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
      imageUrl: '$url',
      height: height,
      width: width,
      fit: fit,
      errorWidget: (_, __, ___) {
        return SizedBox(height: height, width: width);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit);
  }
}
Widget? Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('images/grey.jpg', fit: BoxFit.cover);
setSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: new Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    elevation: 1.0,
  ));
}
Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}