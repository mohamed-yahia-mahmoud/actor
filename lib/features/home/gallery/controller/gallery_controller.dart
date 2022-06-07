import 'dart:io';


import 'package:actor/appCore/network/request/GetPopularPeopleRequest.dart';
import 'package:actor/appCore/network/response/PopularPeopleResponse.dart';
import 'package:actor/appCore/networking/api_provider.dart';
import 'package:actor/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
 import 'package:get/get.dart';
 import 'package:logger/logger.dart';
 import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularPeopleController extends GetxController  with StateMixin<PopularPeopleResponse> {

  var currentIndex = 0.obs;
  var adsId = 0.obs;
  ScrollController scrollController = ScrollController();
  var noImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScPr_e8yD_adDE0sUA6xJykV7Vuwyc0xQoun4XfAANTKGYdq2m99kHFf-Hc_XpY0YVnug&usqp=CAU';

  List<int>? checkListFunctions = [];

  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
  late TextEditingController searchController;
  var search = '';

  late String token;
  List<int> mylist = <int>[];

  @override
  void onInit() {
    searchController = TextEditingController();
    getPopularPeopleData();
    super.onInit();
  }


  int currentPage = 1;

  late int totalPages = 0;
  final RefreshController refreshController = RefreshController(
      initialRefresh: true);
  final ApiService _apiService = Get.put(ApiService());

  int page = 0;

  void loadMore() async {
    scrollController?.addListener(() async {
      if (scrollController?.position.maxScrollExtent ==
          scrollController?.position.pixels) {

      }
    });
  }


  List<Results> popularList = [];
  var myPopularPeopleResponse = PopularPeopleResponse().obs;
  GetPopularPeopleRequest? getPopularPeopleRequest = GetPopularPeopleRequest(
    page: 1,);

  Future<bool> getPopularPeopleData({bool isRefresh = false }) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    getPopularPeopleRequest!.page = currentPage;
    getPopularPeopleRequest!.api_key = "99d82c14f594b2706abe96bbce3e235c";
    getPopularPeopleRequest!.language = "en-Us";
    Logger().i(getPopularPeopleRequest!.toJson());
    client!.getPopularPeople(getPopularPeopleRequest!.toJson(),).then((res) {
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
    return false;
  }


}
