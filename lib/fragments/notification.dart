import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:barber/ResponseModel/notificationResponse.dart';
import 'package:barber/apiservice/Apiservice.dart';
import 'package:barber/apiservice/Retro_Api.dart';
import 'package:barber/appbar/app_bar_only.dart';
import 'package:barber/common/widget.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:barber/constant/preferenceutils.dart';
import 'package:barber/drawer/drawer_only.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:barber/screens/loginscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../bottombar.dart';

class Notification1 extends StatefulWidget {
  Notification1({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Notification1 createState() => _Notification1();
}

class _Notification1 extends State<Notification1> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  List<NotiData> notidatalist = <NotiData>[];
  bool datavisible = false;
  bool nodatavisible = true;
  bool _loading = false;
  String name = "User";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    if (mounted) {
      PreferenceUtils.init();
      if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
        AppConstant.CheckNetwork().whenComplete(() => CallApiForNotification());
        name = PreferenceUtils.getString(AppConstant.username);
      } else {
        Future.delayed(
          Duration(seconds: 0),
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen(3))),
        );

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => LoginScreen()));

      }
    }
  }

  void CallApiForNotification() {
    setState(() {
      _loading = true;
    });
    Future.delayed(Duration(seconds: 0)).then((value) {

    });

    RestClient(Retro_Api().Dio_Data()).notification().then((response) {
      Future.delayed(Duration(seconds: 0)).then((value) {

      });

      setState(() {
        _loading = false;
        if (mounted) {

          Future.delayed(Duration(seconds: 0)).then((value) {


          });

          if (response.success = true) {
            Future.delayed(Duration(seconds: 0)).then((value) {

            });

            print(response.success);
            print(response.data!.length);

            if (response.data!.length > 0) {
              notidatalist.addAll(response.data!);
              datavisible = true;
              nodatavisible = false;
            } else if (response.data!.length == 0) {
              // pr.hide();
              // AppConstant.hideDialog(context);
              print("datavalue:$datavisible");

              datavisible = false;
              nodatavisible = true;
            }

          } else {
            datavisible = false;
            nodatavisible = true;
            AppConstant.toastMessage("No Data");
          }


        }
      });
    }).catchError((Object obj) {

      setState(() {
        _loading = false;
      });

      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");

    });
  }

  List offerdatalist = [
    {
      "discount": "10%",
      "dark_color": const Color(0xFFffb5cc),
      "light_color": const Color(0xFFffc8de),
    },
    {
      "discount": "50%",
      "dark_color": const Color(0xFFb5b8ff),
      "light_color": const Color(0xFFc8caff)
    },
    {
      "discount": "30%",
      "dark_color": const Color(0xFFffb5b5),
      "light_color": const Color(0xFFffc8c8)
    },
  ];
  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    if(screenwidth>500){
      screenwidth = screenwidth *0.6;
    }

    return WillPopScope(
        onWillPop: _onWillPop,

        // color: Colors.white,
        // debugShowCheckedModeBanner: false,

        child: ModalProgressHUD(
          inAsyncCall: _loading,
          opacity: 1.0,
          color: Colors.transparent.withOpacity(0.2),
          progressIndicator:
              SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
          child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                key: _drawerscaffoldkey,
                //set gobal key defined above

                backgroundColor: Colors.white,

                drawer: new DrawerOnly(name),
                body: new Stack(
                  children: <Widget>[
                    new SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(

                            margin: EdgeInsets.only(left: 10),
                            width: screenwidth,
                            color: Colors.white,
                            height: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'NEW',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(right: 10, left: 5),
                                      child: DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 5.0,
                                        dashColor: Colors.black,
                                        dashRadius: 0.0,
                                        dashGapLength: 8.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      )),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: datavisible,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 0.0, left: 10, right: 10),
                              color: Colors.white,
                              width: screenwidth,
                              child: Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Container(
                                      color: Colors.white,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        // constraints: BoxConstraints.expand(),
                                        width: double.infinity,
                                        height: 80,
                                        child: new Row(
                                          children: <Widget>[
                                            new Container(
                                              height: 50,
                                              // width: 40,

                                              width: screenwidth * .12,
// color: Colors.black,
                                              alignment: Alignment.topLeft,

                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    PreferenceUtils.getString(
                                                        AppConstant.salonImage),
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Image.asset(
                                                      "images/no_image.png",fit: BoxFit.fill,),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: screenwidth * .75,
                                                height: 80,
                                                margin: EdgeInsets.only(
                                                    left: 1.0, top: 1),
                                                alignment: Alignment.topLeft,
                                                child: ListView(
                                                  children: <Widget>[
                                                    Container(
                                                      transform: Matrix4
                                                          .translationValues(
                                                              5.0, 0.0, 0.0),
                                                      child: Text(
                                                        notidatalist[index]
                                                            .title!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Montserrat'),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      // child: Text("Dear Test, Your appointment on 2020-11-06 at 11:00AM in Barberque Nation is now Cancel. Your booking id is #56304. Thank you.",
                                                      child: Text(
                                                        notidatalist[index]
                                                            .msg!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 4,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Montserrat'),
                                                      ),
                                                    ),
                                                  ],
                                                )),

                                            /*    Visibility(
                visible: false,
                child: Container(
                  width: screenwidth * .17,

                    // width: 55,
                    height: 20,

                    margin: EdgeInsets.only(left: 1.0),
                    alignment: Alignment.topCenter,

                    child:Visibility(



                      child: RaisedButton(


                        textColor: Colors.white,
                        color: Color(0xFFff0000),
                        child: Text("NEW",  style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,

                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'

                        ),),
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),





                    ),



                    // child:   FlatButton(
                    //   onPressed: () {},
                    //   color: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Text("NEW",style: TextStyle(color: this.dark_color,  fontFamily: 'Montserrat',fontSize: 11),),
                    // )





                ),
              ),*/
                                          ],
                                        ),

                                        // color: Colors.grey,
                                      ),
                                    );

                                    /* return new NotificationData(
                                      discount: offerdatalist[index]['discount'],
                                      dark_color: offerdatalist[index]['dark_color'],
                                      light_color: offerdatalist[index]['light_color'],
                                    );*/
                                  },
                                  itemCount: notidatalist.length,
                                ),
                              ),

                              // height: 50,
                            ),
                          ),

                          // Expanded(

                          // child:Container(
                          // margin: EdgeInsets.only(left: 15,right: 15,top:0,bottom: 60),

                          Visibility(
                            visible: nodatavisible,

                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 10),
                                width: screenwidth,
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                alignment: Alignment.center,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Image.asset(
                                      "images/nodata.png",
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 100,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No Data",
                                        style: TextStyle(
                                            color: Color(0xFFa3a3a3),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          kIsWeb?buildFooter(context, screenwidth):SizedBox(),

                          // ),

                          // )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
  bool status =false;
  Widget buildFooter(BuildContext context,double width){
    return  Container(
      color:Color(AppConstant.pinkcolor),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            SizedBox(height: 80,),
            Center(
              child: Wrap(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: width<480?CrossAxisAlignment.center:CrossAxisAlignment.start,
                      mainAxisAlignment: width<480?MainAxisAlignment.center:MainAxisAlignment.start,
                      children: [
                        Image(image: AssetImage("images/logo.png"),height: 20.w,width: 20.w,),
                        SizedBox(height: 20,),
                        Container(

                          child: Row(
                            crossAxisAlignment: width<480?CrossAxisAlignment.center:CrossAxisAlignment.start,
                            mainAxisAlignment: width<480?MainAxisAlignment.center:MainAxisAlignment.start,

                            children: [

                              MouseRegion(
                                onEnter: (value) {
                                  setState(() {
                                    status=true;
                                  });
                                },
                                onExit: (value) {
                                  setState(() {
                                    status=false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: status?Colors.green:Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.facebook,color: status?Colors.white:Colors.black,)),
                              ),
                              MouseRegion(
                                onEnter: (value) {
                                  setState(() {
                                    status=true;
                                  });
                                },
                                onExit: (value) {
                                  setState(() {
                                    status=false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: status?Colors.green:Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.instagram,color: status?Colors.white:Colors.black,)),
                              ),
                              MouseRegion(
                                onEnter: (value) {
                                  setState(() {
                                    status=true;
                                  });
                                },
                                onExit: (value) {
                                  setState(() {
                                    status=false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: status?Colors.green:Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.twitter,color: status?Colors.white:Colors.black,)),
                              ),
                              MouseRegion(
                                onEnter: (value) {
                                  setState(() {
                                    status=true;
                                  });
                                },
                                onExit: (value) {
                                  setState(() {
                                    status=false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: status?Colors.green:Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.pinterest,color: status?Colors.white:Colors.black,)),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: width<480?CrossAxisAlignment.center:CrossAxisAlignment.start,
                      mainAxisAlignment: width<480?MainAxisAlignment.center:MainAxisAlignment.start,
                      children: [
                        text("OUR SERVICE",fontSize: 6.0.sp,fontFamily: fontBold,),

                        SizedBox(height: 20,),
                        NavBarItem2(
                          text: "Terms and Conditions",
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 12,),
                        NavBarItem2(
                          text: "Privacy Policy",
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 12,),
                        NavBarItem2(
                          text: "Top Offers",
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 12,),
                        NavBarItem2(
                          text: "Invite a Friends",
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 30,),

                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: width<480?CrossAxisAlignment.center:CrossAxisAlignment.start,
                      mainAxisAlignment: width<480?MainAxisAlignment.center:MainAxisAlignment.start,
                      children: [
                        text("Contact",fontSize: 6.0.sp,fontFamily: fontBold,),

                        SizedBox(height: 20,),
                        ContactItem(
                          text: "+256 779 267762 | +256 723 111078",
                          icon: FontAwesomeIcons.phoneSquare,
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 12,),
                        ContactItem(
                          text: "jeremy@matchstick.ug",
                          icon: FontAwesomeIcons.voicemail,
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 12,),
                        ContactItem(
                          text: "Matchstick 256 Studio Plot",
                          icon: FontAwesomeIcons.home,
                          status: width<500?true:false,
                        ),
                        SizedBox(height: 30,),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80,),
            Container(
                color: Colors.green,
                alignment: Alignment.center,
                width: width,
                height: 50,
                child: Text('?? 2021 Beauty Salon, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFFFFFFFF)),)),
          ]
      ),
    );
  }
  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new BottomBar(0)))) ??
        false;
  }
}
