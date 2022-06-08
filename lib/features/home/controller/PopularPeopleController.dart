import 'package:actor/appCore/network/request/GetPersonDetailsRequest.dart';
import 'package:actor/appCore/network/request/GetPersonImagesRequest.dart';
import 'package:actor/appCore/network/request/GetPopularPeopleRequest.dart';
import 'package:actor/appCore/network/response/GetPersonDetailsResponse.dart';
import 'package:actor/appCore/network/response/GetPersonImagesResponse.dart';
import 'package:actor/appCore/network/response/PopularPeopleResponse.dart';
import 'package:actor/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularPeopleController extends GetxController  with StateMixin<PopularPeopleResponse> {

  @override
  void onInit() {
    loadMore();
    super.onInit();
  }

  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  late int totalPages = 0;
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Results> popularList = [];
  List<Profiles> profileList = [];

  /// definition of responses
  var myPopularPeopleResponse = PopularPeopleResponse().obs;
  var myPersonDetailsResponse = GetPersonDetailsResponse().obs;
  var myPersonImagesResponse = GetPersonImagesResponse().obs;

  /// definition of requests
  GetPopularPeopleRequest? getPopularPeopleRequest = GetPopularPeopleRequest(page: 1,);
  GetPersonDetailsRequest? getPersonDetailsRequest = GetPersonDetailsRequest();
  GetPersonImagesRequest? getPersonImagesRequest = GetPersonImagesRequest();

  ///for pagination and loading more next page
  void loadMore() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        getPopularPeopleData();
      }
    });
  }

  /// get popular people fun
  Future<bool> getPopularPeopleData({bool isRefresh = false }) async {
        EasyLoading.show();

    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        print("entered no more");
        refreshController.loadNoData();
        return false;
      }
    }

    getPopularPeopleRequest!.page = currentPage;
    getPopularPeopleRequest!.api_key = "99d82c14f594b2706abe96bbce3e235c";
    getPopularPeopleRequest!.language = "en-Us";
    Logger().i(getPopularPeopleRequest!.toJson());
    client!.getPopularPeople(getPopularPeopleRequest!.toJson(),).then((res) {
      if(EasyLoading.isShow){
        EasyLoading.dismiss();
      }
      if (isRefresh) {
        popularList = res.results ?? [];
      } else {
        popularList.addAll(res.results ?? []);
      }
      myPopularPeopleResponse.value.results = res.results;
      print("my popularList len " + popularList.length.toString());
      currentPage++;
      totalPages = res.totalPages ?? 0;
      update();
      return true;
    }).catchError((Object obj) {
      if(EasyLoading.isShow){
        EasyLoading.dismiss();
      }
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
           final res = (obj as DioError).response;
          Logger().e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");

          Get.snackbar(
            "خطأ",
            res!.statusMessage.toString(),
            icon: const Icon(Icons.person, color: Colors.red),
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,);
          return Future.error(false);
        default:
          final err = (obj).toString();
          Logger().e("Got error : $err");

          break;
      }
    });
    return false;
  }

  /// get details of a specific person
  Future<void> getPopularDetailsData(int personId) async {
     myPersonDetailsResponse.value=GetPersonDetailsResponse();
    EasyLoading.show();
    getPersonDetailsRequest!.api_key = "99d82c14f594b2706abe96bbce3e235c";
    getPersonDetailsRequest!.language = "en-Us";
    Logger().i(getPopularPeopleRequest!.toJson());
    client!.getPopularPeopleDetails(personId,getPopularPeopleRequest!.toJson(),).then((res) {
      myPersonDetailsResponse.value = res;
      print("my myPersonDetailsResponse   " + myPersonDetailsResponse.value.toString());
      update();
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          Logger().e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          Get.snackbar(
            "خطأ",
            res!.statusMessage.toString(),
            icon: const Icon(Icons.person, color: Colors.red),
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,);
           return Future.error(false);
         default:
          final err = (obj).toString();
          Logger().e("Got error : $err");
           break;
      }
    });
  }

  /// get images of a specific person
  Future<void> getPopularImages(int personId) async {
    profileList.clear();
    // EasyLoading.show();
    getPersonImagesRequest!.api_key = "99d82c14f594b2706abe96bbce3e235c";

    Logger().i(getPopularPeopleRequest!.toJson());
    client!.getPersonImages(personId,getPopularPeopleRequest!.toJson(),).then((res) {
      // if(EasyLoading.isShow){
      //   EasyLoading.dismiss();
      // }
        profileList = res.profiles ?? [];

      myPersonImagesResponse.value = res;
      print("my myPersonImagesResponse len " + profileList.length.toString());

      update();
    }).catchError((Object obj) {
      // if(EasyLoading.isShow){
      //   EasyLoading.dismiss();
      // }
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          print("erorrrrrrrrrrrrrrr");
          final res = (obj as DioError).response;
          Logger().e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");

          Get.snackbar(
            "خطأ",
            res!.statusMessage.toString(),
            icon: const Icon(Icons.person, color: Colors.red),
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,);
          return Future.error(false);
        default:
          final err = (obj).toString();
          Logger().e("Got error : $err");

          break;
      }
    });
  }

}
