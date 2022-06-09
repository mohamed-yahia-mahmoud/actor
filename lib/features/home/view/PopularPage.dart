import 'package:actor/features/home/controller/PopularPeopleController.dart';
import 'package:actor/features/home/view/ImagePage.dart';
import 'package:actor/features/home/view/grid_card.dart';
import 'package:actor/features/home/view/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
class PopularPeoplePage extends  GetWidget<PopularPeopleController>  {

  final PopularPeopleController  controller = Get.put(PopularPeopleController());

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<PopularPeopleController>(
      init: PopularPeopleController(),
      builder: (controller) => SafeArea(
          child: Scaffold(

            appBar: AppBar(
              title: const Center(child: Text("Popular people app",style: TextStyle(
                color: Colors.yellow
              ),),),
            ),
              body: Column(
                children: [

                 const SizedBox(height:8),
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
                         }
                      },
                      onLoading: () async {
                        final result = await controller.getPopularPeopleData();
                        if (result) {
                          controller.refreshController.loadComplete();
                        } else {
                           controller.refreshController.loadComplete();
                        }
                      },
                      child: ListView.builder(
                          itemCount: controller.popularList.length,
                          itemBuilder: ( context,  index) {
                            return InkWell(onTap: (){
                              controller.getPopularImages(controller.popularList[index].id);
                              controller.getPopularDetailsData(controller.popularList[index].id);
                              EasyLoading.show();
                              Future.delayed(const Duration(milliseconds: 1500)).then((value) {
                                showBottomSheetForRequest(context);
                                EasyLoading.dismiss();
                              });
                            },
                                child: ImageCard(url:controller.popularList[index].profilePath,itemId: controller.popularList[index].id,)
                            );
                          } ),

                    ),
                    ),


                ],
              ))),
    );
  }
  /// for view the details of the selected person
  void showBottomSheetForRequest(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          maxChildSize: 0.9,
          initialChildSize: 0.88,
          expand: false,
          builder: (context, scrollController) {

              return Column(
                children: [
                  /// name
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 2,bottom: 4,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Name :",style: TextStyle(
                            fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.6)
                        ),),
                        Padding(
                         padding: const EdgeInsets.only(left:4.0),
                         child: Text(controller.myPersonDetailsResponse.value.name??"",style: const TextStyle(
                             fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black
                         ),),
                          ),
                      ],
                    ),
                  ),
                  ///department
                  Padding(
                    padding: const EdgeInsets.only(top:4.0,right: 2,bottom: 4,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Department :",style: TextStyle(
                            fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.6)
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Text(controller.myPersonDetailsResponse.value.knownForDepartment??"",style: const TextStyle(
                              fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                  ),
                  ///Date of Birth
                  Padding(
                    padding: const EdgeInsets.only(top:4.0,right: 2,bottom: 4,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Date of Birth :",style: TextStyle(
                            fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.6)
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Text(controller.myPersonDetailsResponse.value.birthday??"",style: const TextStyle(
                              fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                  ),
                  ///Country
                  Padding(
                    padding: const EdgeInsets.only(top:4.0,right: 2,bottom: 4,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Country :",style: TextStyle(
                            fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.6)
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Text(controller.myPersonDetailsResponse.value.placeOfBirth??"",style: const TextStyle(
                              fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                  ),
                  ///bio
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20,top: 4,bottom: 8),
                    child: Text(controller.myPersonDetailsResponse.value.biography??"",
                      style: TextStyle(overflow: TextOverflow.ellipsis,
                        fontSize: 11,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(.6)
                    ),maxLines: 10,),
                  ),
                  /// a gridview of images for the selected person
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.54,
                    child:  GridView.builder(
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10),
                        padding: const EdgeInsets.only(bottom:10,left: 15,right: 15),
                        itemCount: controller.profileList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            InkWell(
                                onTap: (){
                                  controller.openedPersonProfileImage=controller.profileList[index];
                                  Get.to(ImagePage());
                                },
                                child: GridCard(url:controller.profileList[index].filePath,itemId:  index ));
                        }
                    ),
                  )
                ],
              );

            }
        );
      },
    );

  }

}