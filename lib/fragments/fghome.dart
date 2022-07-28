
import 'package:barber/ResponseModel/bannerResponse.dart';
import 'package:barber/ResponseModel/categorydataResponse.dart';
import 'package:barber/ResponseModel/salonResponse.dart';
import 'package:barber/apiservice/Apiservice.dart';
import 'package:barber/apiservice/Retro_Api.dart';
import 'package:barber/bottombar.dart';
import 'package:barber/common/widget.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:barber/constant/preferenceutils.dart';
import 'package:barber/drawer/drawer_only.dart';
import 'package:barber/screens/salon_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FgHome extends StatefulWidget {
  FgHome({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _FgHome createState() => _FgHome();
}

class _FgHome extends State<FgHome> {
  List<Data1> banner_image = <Data1>[];
  List<String> image12 = <String>[];
  List<String?> banner_title = <String?>[];
  List<CategoryData> categorydataList = <CategoryData>[];
  List<SalonData> salondataList = <SalonData>[];
  String name = "User";
  bool _loading = false;

  int index = 0;

  String current_address = "No address found";
  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        PreferenceUtils.init();
        name = PreferenceUtils.getString(AppConstant.username);

        AppConstant.CheckNetwork().whenComplete(() => CallApiforBanner());
        AppConstant.CheckNetwork().whenComplete(() => CallApiForCategory());

        AppConstant.cuttentlocation()
            .whenComplete(() => AppConstant.cuttentlocation().then((value) {
                  current_address = value;
                }));
      });
      // BackButtonInterceptor.add(myInterceptor);
    }
  }




  void CallApiforBanner() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).banners().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            banner_image.addAll(response.data!);
            image12.clear();
            for (int i = 0; i < banner_image.length; i++) {
              image12.add(banner_image[i].imagePath! + banner_image[i].image!);
              banner_title.add(banner_image[i].title);
            }
            int length123 = image12.length;
            print("StringlistSize:$length123");
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void CallApiForCategory() {
    setState(() {
      _loading = true;
    });
    RestClient(Retro_Api().Dio_Data()).categories().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            categorydataList.addAll(response.data!);
            int size = categorydataList.length;
            print("CATEGORY DATA==" + response.data.toString());
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
    });
  }
  TextEditingController pinCon=new TextEditingController();

  PersistentBottomSheetController? controller;
  void createBottomSheet(id,name)async{
    controller=await _drawerscaffoldkey.currentState!.showBottomSheet((context){
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color:Colors.white),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            text(
                'Select Details',
                fontFamily: fontMedium,
                fontSize: 16.0,
                textColor: Colors.black,isCentered: true
            ),
            SizedBox(
              height: 30,
            ),
            text(
                'Gender',
                fontFamily: fontRegular,
                fontSize: 14.0,
                textColor: Colors.black,isCentered: true
            ),
            SizedBox(
              height: 10,
            ),
            getButton(400.00),
            /*  Container(
                    decoration:boxDecoration(
                      color: Color(0xFFCCCCCC),
                      bgColor: Colors.white,
                    ),
                    child: TextField(
                      cursorColor: TextSecondaryColor.withOpacity(0.2),
                      cursorWidth: 1,

                      controller: typeController,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Enter Fuel Type',
                        hintStyle: secondaryTextStyle(
                            textColor:textColorSecondary.withOpacity(0.7)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 16, bottom: 16, top: 16, right: 16),
                      ),
                    ),
                  ),*/
            SizedBox(
              height: 30,
            ),
            text(
                'Pin Code',
                fontFamily: fontRegular,
                fontSize: 14.0,
                textColor: Colors.black,isCentered: true
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration:boxDecoration(
                color: Color(0xFFCCCCCC),
                bgColor: Colors.white,
              ),
              child: TextField(
                cursorColor: Colors.black.withOpacity(0.2),
                cursorWidth: 1,
                controller: pinCon,
                keyboardType: TextInputType.phone,
                autocorrect: true,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Enter Pin Code',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                      left: 16, bottom: 16, top: 16, right: 16),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
           NewButton( selected:false,
              textContent:  "Next",
              onPressed: () {
                /*if(typeController.text==""){
                      *//*  scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: text("Please Enter Valid Otp Number",fontFamily: fontMedium,
                            textColor: Colors.white),
                        behavior: SnackBarBehavior.floating,
                      ));*//*
                      Toast.show("Please Enter Type",context);
                      return ;
                    }*/
                if(pinCon.text==""){
                  /*  scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: text("Please Enter Valid Otp Number",fontFamily: fontMedium,
                            textColor: Colors.white),
                        behavior: SnackBarBehavior.floating,
                      ));*/
                  setSnackbar("Please Enter Pin Code", context);
                  return ;
                }
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                        new SalonScreen(
                          specialList:id.toString(),categoryName:name.toString(),gender:text1,pinCode:pinCon.text.trim())));
              },),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    },
      backgroundColor: Colors.transparent,
      elevation: 10,
    );

  }
  String text1="Male";
  Widget getButton(double width){
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller!.setState!((){
              text1="Male";
            });
          },
          child: Container(
              width: width * 0.209,
              height: 40,
              decoration: boxDecoration(
                  color: Colors.pink ,
                  bgColor: text1=="Male"? Colors.pink : Colors.white,
                  radius: 30.0),
              margin: EdgeInsets.all(5.0),
              child: Center(
                child: text("Male",
                    fontFamily: fontMedium,
                    fontSize: 10.0,
                    isCentered: true,
                    textColor: text1!="Male" ? Colors.pink : Colors.white),
              )),
        ),
        SizedBox(width: 5,),
        InkWell(
          onTap: () {
            controller!.setState!((){
              text1="Female";
            });
            setState(() {
              text1="Female";
            });
          },
          child: Container(
              width: width * 0.209,
              height: 40,
              decoration: boxDecoration(
                  color: Colors.pink ,
                  bgColor: text1=="Female"? Colors.pink : Colors.white,
                  radius: 30.0),
              margin: EdgeInsets.all(5.0),
              child: Center(
                child: text("Female",
                    fontFamily: fontMedium,
                    fontSize: 10.0,
                    isCentered: true,
                    textColor: text1!="Female" ? Colors.pink : Colors.white),
              )),
        ),
        SizedBox(width: 5,),
        InkWell(
          onTap: () {
            controller!.setState!((){
              text1="Both";
            });
            setState(() {
              text1="Both";
            });
          },
          child: Container(
              width: width * 0.209,
              height: 40,
              decoration: boxDecoration(
                  color: Colors.pink ,
                  bgColor: text1=="Both"?Colors.pink : Colors.white,
                  radius: 30.0),
              margin: EdgeInsets.all(5.0),
              child: Center(
                child: text("Both",
                    fontFamily: fontMedium,
                    fontSize: 10.0,
                    isCentered: true,
                    textColor: text1!="Both" ? Colors.pink : Colors.white),
              )),
        ),
      ],
    );
  }
  int _current = 0;

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  bool status =false;
  Widget buildFooter(BuildContext context,double width){
    return  Container(
        color:Color(AppConstant.pinkcolor),
      width: width,
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
                child: Text('© 2021 Beauty Salon, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFFFFFFFF)),)),
          ]
      ),
    );
  }


  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    double defaultScreenWidth = screenwidth;
    double defaultScreenHeight = screenHeight;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
        /*BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),*/
        context,
        designSize: Size(360, 690),
       // orientation: Orientation.portrait
        );

    return  ModalProgressHUD(
          inAsyncCall: _loading,
          opacity: 1.0,
          color: Colors.transparent.withOpacity(0.2),
          progressIndicator:
              SpinKitFadingCircle(color: Color(AppConstant.pinkcolor)),
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                key: _drawerscaffoldkey,
                drawer: new DrawerOnly(name),
                body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Code for image slider

                        Container(
                          width: screenwidth,
                          height: screenwidth>500?300:200,
                          color: Colors.transparent,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Card(
                            elevation: 10,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: screenwidth>500?290:190,
                                      viewportFraction: 1.0,
                                      onPageChanged: (index, index1) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                    ),

                                    // items: image12.map((it){

                                    items: banner_image.map((it) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: Stack(
                                            children: <Widget>[
                                              Material(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                elevation: 2.0,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                type: MaterialType.transparency,
                                                /*  child: Image.network(it,
                                                    height: 200,
                                                    width: 500,
                                                    fit: BoxFit.fitWidth,
                                                ),*/
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black12
                                                          .withOpacity(0.4),
                                                      BlendMode.srcOver),
                                                  child: CachedNetworkImage(
                                                    imageUrl: it.imagePath! +
                                                        it.image!,
                                                    width: screenwidth,
                                                    height: screenwidth>500?300:200,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            SpinKitFadingCircle(
                                                      color: Color(AppConstant
                                                          .pinkcolor),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "images/no_image.png",fit: BoxFit.fill,),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  it.title!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )
                                              // (() {
                                              //   for (int i = 0;
                                              //       i < banner_image.length;
                                              //       i++)
                                              //     return Center(
                                              //       child: Text(
                                              //         banner_title[i]!,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontSize: 26,
                                              //             fontWeight:
                                              //                 FontWeight.w800),
                                              //       ),
                                              //     );
                                              // }()),
                                            ],
                                          ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: map<Widget>(image12, (index, url) {
                                  //     return Container(
                                  //       alignment: Alignment.bottomCenter,
                                  //       width: 9.0,
                                  //       height: 9.0,
                                  //       margin: EdgeInsets.symmetric(
                                  //           vertical: 10.0, horizontal: 2.0),
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         color: _current == index
                                  //             ? Color(AppConstant.pinkcolor)
                                  //             : Color(0xFFffffff),
                                  //       ),
                                  //     );
                                  //   }) as List<Widget>,
                                  // ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          image12.length,
                                          (index) => Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width: 9.0,
                                                height: 9.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _current == index
                                                      ? Color(
                                                          AppConstant.pinkcolor)
                                                      : Color(0xFFffffff),
                                                ),
                                              ))
                                      // map<Widget>(image12, (index, url) {
                                      //   return ;
                                      // }) as List<Widget>,
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0, top: 15),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Top Categories',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: GridView.count(
                            childAspectRatio: 1.2,
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: ScreenUtil().setWidth(10),
                            children:
                                List.generate(categorydataList.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    print(index);
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopService(index,categorydataList[index].name)));
                                  /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new DetailBarber(
                                                    categorydataList[index]
                                                        .catId)));*/
                                      createBottomSheet(categorydataList[index].catId,categorydataList[index].name);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        right: ScreenUtil().setWidth(10)),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                            child: commonCacheImageWidget(categorydataList[index]
                                                .imagePath! +
                                                categorydataList[index]
                                                    .image!.toString(), screenwidth>500?screenwidth*0.27:height*0.1, width: screenwidth * 0.43, fit: BoxFit.cover),
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Text(
                                              categorydataList[index].name![0].toUpperCase()+categorydataList[index].name!.substring(1).toString(),
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 12.sp, color: AppTextColorPrimary, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        kIsWeb?buildFooter(context,width):SizedBox(),
                      ],
                    ))),
          ),
        );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App ?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text("YES"),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }
}
