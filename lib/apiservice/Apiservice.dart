import 'package:barber/ResponseModel/appointmentResponse.dart';
import 'package:barber/ResponseModel/bannerResponse.dart';
import 'package:barber/ResponseModel/bookingResponse.dart';
import 'package:barber/ResponseModel/cancelAppointResponse.dart';
import 'package:barber/ResponseModel/categorydataResponse.dart';
import 'package:barber/ResponseModel/catviseSalonResponse.dart';
import 'package:barber/ResponseModel/changepasswordResponse.dart';
import 'package:barber/ResponseModel/checkCouponResponse.dart';
import 'package:barber/ResponseModel/editprofileresponse.dart';
import 'package:barber/ResponseModel/empResponse.dart';
import 'package:barber/ResponseModel/forgotpasswodResponse.dart';
import 'package:barber/ResponseModel/notificationResponse.dart';
import 'package:barber/ResponseModel/offerResponse.dart';
import 'package:barber/ResponseModel/offerbannerResppose.dart';
import 'package:barber/ResponseModel/otpmatchResponse.dart';
import 'package:barber/ResponseModel/paymentGatwayResponse.dart';
import 'package:barber/ResponseModel/registerResponse.dart';
import 'package:barber/ResponseModel/removeAddressResponse.dart';
import 'package:barber/ResponseModel/salonDetailResponse.dart';
import 'package:barber/ResponseModel/salonResponse.dart';
import 'package:barber/ResponseModel/settingResponse.dart';
import 'package:barber/ResponseModel/showprofileResponse.dart';
import 'package:barber/ResponseModel/timedataResponseModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'Apiservice.g.dart';

@RestApi(baseUrl: "https://alphawizztest.tk/salonezy/public/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("login")
  @FormUrlEncoded()
  Future<String?> login(
    @Field() String? email,
    @Field() String? password,
    @Field() String device_token,
  );

  @POST("register")
  @FormUrlEncoded()
  Future<registerResponse> register(
    @Field() String? name,
    @Field() String? email,
    @Field() String? phone,
    @Field() String? password,
    @Field() int verify,
    @Field() String? code,
  );

  @POST("checkotp")
  @FormUrlEncoded()
  Future<otpmatchResponse> checkotp(
    @Field() String otp,
    @Field() String user_id,
  );

  @POST("sendotp")
  @FormUrlEncoded()
  Future<otpmatchResponse> sendotp(
    @Field() String email,
  );

  @GET("banners")
  Future<bannerResponse> banners();

  @GET("coupon")
  Future<offerResponse> coupon();

  @GET("offers")
  Future<offerbannerResppose> offersbanner();

  @GET("categories")
  Future<categorydataResponse> categories();

  @GET("salons")
  Future<salonResponse> salons();

  @GET("salon")
  Future<salonDetailResponse> salondetail();

  @GET("catsalon/{id}")
  Future<catviseSalonResponse> catsalon(
    @Path() int id,
  );

  @GET("profile")
  Future<showprofileResponse> profile();

  @GET("profile/address/remove/{id}")
  Future<removeAddressResponse> removeadd(
    @Path() int? id,
  );

  @POST("profile/edit")
  @FormUrlEncoded()
  Future<editprofileresponse> editprofile(
    @Field() String image,
    @Field() String? email,
    @Field() String? phone,
    @Field() String? name,
    @Field() String? code,
  );

  @POST("booking")
  @FormUrlEncoded()
  Future<bookingResponse> booking(
      @Field() int? salon_id,
    @Field() String emp_id,
    @Field() String service_id,
    @Field() String payment,
    @Field() String date,
    @Field() String start_time,
    @Field() String payment_type,
    @Field() String payment_token,
  );

  @POST("booking")
  @FormUrlEncoded()
  Future<String?> booking1(
    @Field() String salon_id,
    @Field() String emp_id,
    @Field("service_id") List<int> service_id,
    @Field() String payment,
    @Field() String date,
    @Field() String start_time,
    @Field() String payment_type,
    @Field() String payment_token,
  );

  @POST("selectemp")
  @FormUrlEncoded()
  Future<empResponse> selectemp(
    @Field() String? start_time,
    @Field() String service,
    @Field() String? date,
      @Field() int? salon_id,
  );

  @POST("timeslot")
  @FormUrlEncoded()
  Future<timedataResponseModel> timeslot(
    @Field() int? salon_id,
    @Field() String? date,
  );

  @POST("selectemp")
  @FormUrlEncoded()
  Future<String?> selectemp1(
    @Field() String start_time,
    @Field("service") List<int> service,
    @Field() String salon_id,
    @Field() String date,
  );

  @GET("appointment")
  Future<appointmentResponse> appointment();

  @GET("appointment/cancel/{id}")
  Future<cancelAppointResponse> removeappointment(
    @Path() int id,
  );

  @GET("settings")
  Future<settingResponse> settings();

  @GET("notification")
  Future<notificationResponse> notification();

  @POST("forgetpassword")
  @FormUrlEncoded()
  Future<forgotpasswodResponse> forgetpassword(
    @Field() String? email,
  );

  @POST("checkcoupon")
  @FormUrlEncoded()
  Future<checkCouponResponse> checkcoupon(
    @Field() String? code,
  );

  @GET("payment_gateway")
  Future<paymentGatwayResponse> paymentgateway();

  @POST("addreview")
  @FormUrlEncoded()
  Future<checkCouponResponse> addreview(
    @Field() String? message,
    @Field() String rate,
    @Field() String booking_id,
      @Field() String salon_id,
  );

  @GET("salon/{id}")
  Future<String?> salondetail1(
    @Path() int id,
  );

  @GET("deletereview/{id}")
  Future<String?> deletereview(
    @Path() int id,
  );

  @POST("changepassword")
  @FormUrlEncoded()
  Future<changepasswordResponse> changepassword(
    @Field() String? oldPassword,
    @Field() String? new_Password,
    @Field() String? confirm,
  );
}
