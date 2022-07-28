import 'dart:collection';
import 'dart:io';

import 'package:barber/apiservice/Retro_Api.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:barber/constant/preferenceutils.dart';
import 'package:barber/drawer/drawer_only.dart';
import 'package:barber/fragments/appoinment.dart';
import 'package:barber/fragments/fghome.dart';
import 'package:barber/fragments/notification.dart';
import 'package:barber/screens/loginscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import 'apiservice/Apiservice.dart';
import 'appbar/app_bar_only.dart';
import 'common/inndicator.dart';
import 'common/widget.dart';
import 'drawerscreen/privacypolicy.dart';
import 'drawerscreen/tems_condition.dart';
import 'drawerscreen/top_offers.dart';
import 'fragments/profile.dart';

class BottomBar extends StatefulWidget {
  int index;
  int save_prev_index = 2;

  BottomBar(this.index);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> with SingleTickerProviderStateMixin{
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool? login = false;
  late TabController _tabController;
  late LocationData _currentPosition;
  late String _address = "", _dateTime;
  Location location1 = Location();
  List<String> tabName = ["Home","Appointment","Notifications","Profile"];
  List<Widget> tabWidget = [
    FgHome(),
    Appoinment(),
    Notification1(),
    Profile(),];
  bool status = false;
  String firstLocation = "",lat = "",lng = "";
  bool logoutVisible = false;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
  new GlobalKey<ScaffoldState>();
  String? name = "User";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    getLoc();
    PreferenceUtils.init();

    name = PreferenceUtils.getString(AppConstant.username);
    print("UserName:$name");

    if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
      logoutVisible =true;
      CallProfileapi();
    }
  }
  void CallProfileapi() {
    RestClient(Retro_Api().Dio_Data()).profile().then((response) {
      if (mounted) {
        setState(() {
          if (response.success = true) {
            name = response.data!.name;
            PreferenceUtils.setString(
                AppConstant.username, response.data!.name!);
          } else {
            AppConstant.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error__123");
    });
  }
  @override
  Widget build(BuildContext context) {
    login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);

    return WillPopScope(
        onWillPop: _onWillPop,

        // color: Colors.white,
        // debugShowCheckedModeBanner: false,

        child: Scaffold(
      // body:(_getBody(index)),
      key: _drawerscaffoldkey,
      // 0a8dd3a0-17c9-490d-9178-1a9d4863448a
      appBar: SizerUtil.deviceType == DeviceType.mobile?appbar(context, tabName[_tabController.index], _drawerscaffoldkey, true)
      as PreferredSizeWidget?:PreferredSize(child: DeskTopBar(), preferredSize: AppBar().preferredSize),
        drawer: DrawerOnly(name),
      body: tabWidget[index],
      bottomNavigationBar: SizerUtil.deviceType == DeviceType.mobile?TabBar(
        controller: _tabController,
        tabs: [
          /*     Tab(
                    icon: Container(
                        width: 20,
                        height: 20,
                        child: new SvgPicture.asset("images/location_white.svg")
                    ),
                  ),*/
          Tab(
            icon: Container(
                width: 20,
                height: 20,
                child: new SvgPicture.asset("images/home_white.svg")),
          ),
          Tab(
            icon: GestureDetector(
              child: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset("images/calendar_white.svg")),
            ),
          ),
          Tab(
            icon: Container(
                width: 20,
                height: 20,
                child: new SvgPicture.asset("images/notification_white.svg")),
          ),
          Tab(
            icon: Container(
                width: 20,
                height: 20,
                child: new SvgPicture.asset("images/profile_white.svg")),
          ),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(0.0),
        indicatorColor: Colors.white,
        indicatorWeight: 3.0,
        indicator: MD2Indicator(
          indicatorSize: MD2IndicatorSize.full,
          indicatorHeight: 5.0,
          indicatorColor: Colors.white,
        ),
        onTap: (value) {
          _navigationQueue.addLast(index);
          // index = value;
          setState(() => index = value);

          print(value);
        },
      ):Container(
            height: 1,
      ),
      backgroundColor: Color(AppConstant.pinkcolor),
    ));
  }
  String curTab="Home",hoverTab = "";
  DeskTopBar(){
    return AppBar(
      backgroundColor: Color(AppConstant.pinkcolor),
      leadingWidth: 10.w,
      leading: Container(
          width: 10.w,
          height: 10.w,
          padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
          child: Image.asset("images/logo.png")),
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
            child: text(tabName[index],fontSize: 6.sp,fontFamily: fontBold,textColor: Colors.white)),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: tabName.map((e){
                int i = tabName.indexWhere((element) => element==e);
                return    MouseRegion(
                  onEnter: (value) {
                    setState(() {
                      hoverTab = e;
                    });
                  },
                  onExit: (value) {
                    setState(() {
                      hoverTab = "";
                    });
                  },
                  child: TextButton(onPressed: (){
                    setState(() {
                      curTab = e;
                      index =tabName.indexWhere((element) => element==e);
                    });
                  }, child: Container(
                      decoration: boxDecoration(
                        radius: 10,
                        bgColor: curTab==e ? Colors.white:hoverTab==e?Colors.white.withOpacity(0.3):Colors.transparent,
                        color: Colors.white,
                      ),
                      width: 12.w,
                      height: 6.h,
                      child: Center(child: text(e,fontSize: 4.sp,fontFamily: fontMedium,textColor: curTab==e ?  Color(AppConstant.pinkcolor):Colors.white,decoration: curTab==e ?true:false)))),
                );
              }).toList(),
            ),
          ),
          Visibility(
            visible: logoutVisible,
            child: MouseRegion(
              onEnter: (value) {
                setState(() {
                  hoverTab = "Logout";
                });
              },
              onExit: (value) {
                setState(() {
                  hoverTab = "";
                });
              },
              child: TextButton(onPressed: (){
                PreferenceUtils.clear();
                PreferenceUtils.setlogin(AppConstant.isLoggedIn, false);

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => new LoginScreen(6)));

              }, child: Container(
                  decoration: boxDecoration(
                    radius: 10,
                    bgColor: curTab=="Logout" ? Colors.white:hoverTab=="Logout"?Colors.white.withOpacity(0.3):Colors.transparent,
                    color: Colors.white,
                  ),
                  width: 12.w,
                  height: 6.h,
                  child: Center(child: text("Logout",fontSize: 4.sp,fontFamily: fontMedium,textColor: curTab=="Logout" ?  Color(AppConstant.pinkcolor):Colors.white,decoration: curTab=="Logout" ?true:false)))),
            ),
          ),
        ],

    );
  }

  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location1.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location1.requestService();
      if (!_serviceEnabled) {
        print('ek');
        return;
      }
    }

    _permissionGranted = await location1.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location1.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('no');
        return;
      }
    }

    location1.onLocationChanged.listen((LocationData currentLocation) {
      // print("${currentLocation.latitude} : ${currentLocation.longitude}");
      if (mounted) {
        setState(() {
          _currentPosition = currentLocation;
          // print(currentLocation.latitude);

          _getAddress(_currentPosition.latitude,
              _currentPosition.longitude)
              .then((value) {
            setState(() {
              _address = "${value.first.addressLine}";
              firstLocation = value.first.subLocality.toString();
            });
          });
        });
      }
    });
  }

  Future<List<Address>> _getAddress(double? lat, double? lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
  Future<List<Address>> _getAddress1(String address) async {
    var add =
    await Geocoder.local.findAddressesFromQuery(address);
    return add;
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }
  Widget buildFooter(BuildContext context,double width){
    return  new Column(
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
                      Image(image: AssetImage("images/logo.png"),height: 5.w,width: 5.w,),
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
    );
  }
}

double collapsableHeight = 0.0;
Color selected = Colors.green;
Color notSelected = Colors.white;
class NavBarItem2 extends StatefulWidget {
  final String text;
  final bool status;

  NavBarItem2({
    required this.text,
    required this.status,
  });

  @override
  _NavBarItem2State createState() => _NavBarItem2State();
}

class _NavBarItem2State extends State<NavBarItem2> {
  Color color = notSelected;
  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return  MouseRegion(
      onEnter: (value) {
        setState(() {
          color = selected;


        });
      },
      onExit: (value) {
        setState(() {
          color = notSelected;

        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            if(widget.text.contains("Terms")){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => new TermsCondition()));
            }
            if(widget.text.contains("Offers")){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => new TopOffers(-1,null,null,null,null,null,null,null,null,null)));

            }
            if(widget.text.contains("Privacy")){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => new PrivacyPolicy()));

            }
            if(widget.text.contains("Invite")){
              Share.share(
                  'Beauty Salon app link');
            }
          },
          child: Container(
            alignment: widget.status?Alignment.center:Alignment.centerLeft,
            child:   Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class ContactItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool status;

  ContactItem({
    required this.text,
    required this.icon,
    required this.status,
  });

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: widget.status?CrossAxisAlignment.center:CrossAxisAlignment.start,
        mainAxisAlignment:widget.status?MainAxisAlignment.center:MainAxisAlignment.start,

        children: [
          FaIcon(widget.icon,size: 20,color: notSelected,),
          SizedBox(width: 5,),
          text(widget.text,fontSize: 12.0,textColor: notSelected,),
        ],
      ),
    );
  }
}