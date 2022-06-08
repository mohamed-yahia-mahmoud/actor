import 'package:actor/features/home/gallery/controller/gallery_controller.dart';
import 'package:actor/features/home/gallery/view/image_card.dart';
import 'package:actor/features/home/gallery/view/popular_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularPeoplePage extends  GetWidget<PopularPeopleController>  {

  final PopularPeopleController  controller = Get.put(PopularPeopleController());

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<PopularPeopleController>(
      init: PopularPeopleController(),
      builder: (controller) => SafeArea(
          child: Scaffold(

              body: Column(
                children: [
                  AppBarWidget(isFilter: false,isSideMenu: false,isSearchBar: false,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical:6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 30.0,
                          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color(0xff4184CE)
                          ),
                          child: Text('Popular',style: TextStyle(color: Colors.white,fontSize: 15 ),),
                        ),
                        const Icon(Icons.save_alt,)
                        // SvgPicture.asset('images/savetodrive.svg',height: 52.43.h,
                        //   width: 47.43.w,fit: BoxFit.fitHeight,),
                      ],
                    ),
                  ),

                  SizedBox(height:18),
                  Expanded(
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await controller.getPopularPeopleData(isRefresh: true);
                        if (result) {
                          controller.refreshController.refreshCompleted();
                        } else {
                          controller.refreshController.refreshFailed();
                          //controller.refreshController.isLoading?CircularProgressIndicator():null;
                        }
                      },
                      onLoading: () async {
                        final result = await controller.getPopularPeopleData();
                        if (result) {

                          controller.refreshController.position!.maxScrollExtent ==1.0?
                          controller.getPopularPeopleData(isRefresh: false):print("not end yet");
                          controller.refreshController.loadComplete();
                        } else {
                         // controller.refreshController.isLoading?CircularProgressIndicator():controller.refreshController.loadComplete();
                          controller.refreshController.loadComplete();
                        }
                      },
                      child: ListView.builder(
                          itemCount: controller.popularList.length,
                          itemBuilder: ( context,  index) {
                            return ImageCard(url:controller.popularList[index].profilePath,itemId: controller.popularList[index].id,);
                          } ),
                      /*GridView.builder(
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10),
                          padding: const EdgeInsets.only(bottom:10,left: 15,right: 15),
                          itemCount: controller.popularList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return
                            ImageCard(url:controller.popularList[index].profilePath,itemId: controller.popularList[index].id,);
                          }
                      ),*/
                    ),
                    ),


                ],
              ))),
    );
  }

}