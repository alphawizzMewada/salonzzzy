import 'package:barber/apiservice/ApiBaseHelper.dart';
import 'package:barber/common/widget.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:barber/model/salon_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detailbarber.dart';


class SalonScreen extends StatefulWidget {


  final String? specialList;
  final String? categoryName;
  final String? gender;
  final String? pinCode;
  SalonScreen({this.specialList,this.categoryName,this.gender,this.pinCode});

  @override
  SalonScreenState createState() => SalonScreenState();
}

class SalonScreenState extends State<SalonScreen> {
   List<SalonModel> bestSpecialList = [];
   ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
   bool status = false;
  @override
  void initState() {
    super.initState();
    getSalonList();
  }
  getSalonList()async{
    Map param ={
      "pincode" :widget.pinCode,
      "gender" :widget.gender,
      "category_id" :widget.specialList,
    };

    print(param.toString());

   Map response = await apiBaseHelper.postAPICall("filterSalon", param, "");
   setState(() {
     status = true;
   });

    for(var v in response['data']['salon']){
        setState(() {
            status = true;
            bestSpecialList.add(new SalonModel(v['salon_id'].toString(), v['name'].toString(), v['imagePath'].toString()+v['image'].toString(), v['desc'].toString(), v['date'].toString()));
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(widget.categoryName![0].toUpperCase()+widget.categoryName!.substring(1), style: TextStyle(color: AppTextColorPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              status?bestSpecialList.length>0?GridView.count(
                childAspectRatio: 1.0,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                children: bestSpecialList.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                              new DetailBarber(int.parse(e.id.toString()), e.name.toString())));
                    },
                    child: Container(
                      //width: context.width() * 0.45,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: GreyColor.withOpacity(0.3), offset: Offset(0.0, 1.0), blurRadius: 2.0)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              child: commonCacheImageWidget(e.image.toString(),   width>500?width*0.27:height*0.12, width: width * 0.43, fit: BoxFit.cover),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              e.name.toString(),
                              style: TextStyle(fontSize: 12.sp, color: AppTextColorPrimary, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(e.desc.toString(), maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10.sp, color: AppTextColorSecondary)),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ):Center(child: Text("No Salon Available")):Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
