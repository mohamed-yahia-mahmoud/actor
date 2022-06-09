import 'package:actor/features/home/controller/PopularPeopleController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
class ImagePage extends  GetWidget<PopularPeopleController>  {
  final PopularPeopleController  controller = Get.put(PopularPeopleController());
  @override
  Widget build(BuildContext context) {
    return   GetBuilder<PopularPeopleController>(
      init: PopularPeopleController(),
      builder: (controller) => SafeArea(
          child: Scaffold(

            appBar: AppBar(
              title: const Center(child: Text("Image",style: TextStyle(
                color: Colors.yellow
              ),),),
              actions:[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0),
                  child: InkWell(
                    onTap: ()async{
                      /// download an image
                      if( controller.openedPersonProfileImage!.filePath!=null){
                        try {
                          /// Saved with this method.
                          var imageId = await ImageDownloader.downloadImage("https://image.tmdb.org/t/p/w500/"+controller.openedPersonProfileImage!.filePath!);
                          if (imageId == null) {
                            Get.snackbar("Sorry","Image not saved 😞");
                            return;
                          }else{
                              Get.snackbar("Success","Image saved 😊");
                          }
                        } on PlatformException catch (error) {
                          Get.snackbar("Sorry","Image not saved 😞");
                          print(error);
                        }
                      }
                    },
                      child: const Icon(Icons.save_alt,color: Colors.white,)),
                ),
              ],
            ),
              body: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: controller.openedPersonProfileImage!.aspectRatio!,
                  child: Container(
                   width: double.parse(controller.openedPersonProfileImage!.width.toString()),
                    height: double.parse(controller.openedPersonProfileImage!.height.toString()),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: controller.openedPersonProfileImage!.filePath!=null?NetworkImage("https://image.tmdb.org/t/p/w500/"+controller.openedPersonProfileImage!.filePath!):
                      const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScPr_e8yD_adDE0sUA6xJykV7Vuwyc0xQoun4XfAANTKGYdq2m99kHFf-Hc_XpY0YVnug&usqp=CAU')
                          ,fit: BoxFit.fill)
                    ),
                  ),
                ),
              ))),
    );
  }

}