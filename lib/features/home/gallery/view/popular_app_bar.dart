import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;


class AppBarWidget extends StatelessWidget {
  double? my_height;
  TextEditingController? controller;
  bool? isBack, isSearchBar,isSideMenu,isFilter,
      isNotification,searchBarBigLeft,searchBarBigRight;
  VoidCallback?  backPressed,searchPressed,filterPressed,
      sideMenuPresses,notificationPresses;

  String? searchHint;
  Widget? widgetInsteadSearchBar;

  AppBarWidget({
    Key? key,
    this.controller,
    this.my_height,
    this.widgetInsteadSearchBar,
    this.isBack = true,
    this.searchBarBigLeft = true,
    this.searchBarBigRight = true,
    this.isSearchBar = false,
    this.isSideMenu = true,
    this.isFilter = true,
    this.isNotification = false,
    this.backPressed,
    this.filterPressed,
    this.searchHint,
    this.searchPressed,
    this.sideMenuPresses,
    this.notificationPresses
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:my_height??120,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 17.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(isSideMenu == true)  Row(
                children: [

                  InkWell(
                    /// To Do side menu on pressed
                    onTap: sideMenuPresses,
                    child: Container(
                      child: Image.asset(
                        "images/Nav.png",
                         height:35.6 ,width: 32 ,
                        // color: AppStyle.blueTextButton,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              widgetInsteadSearchBar ?? Container(),
              if(isSearchBar == true) Expanded(
                child: SizedBox(
                  height: 34 ,
                  child: Row(
                    children: [
                      if(searchBarBigRight == false) Container(
                        width: 50,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextFormField(
                            controller: controller,
                            style: TextStyle(fontSize: 15 ),
                            // textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:  EdgeInsets.symmetric(vertical: 0),
                              hintText: searchHint,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: searchPressed,
                                  child: const Icon(Icons.search)
                                ),
                              ),
                              suffixIcon: isFilter == true ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: filterPressed,
                                  child:  const Icon(Icons.filter_alt_outlined)
                                ),
                              ):Container(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(.9),
                              hintStyle: TextStyle(
                                  color: const Color(
                                    0xffA5A5A5,
                                  ),
                                  fontSize: 15 ),
                            ),
                            // controller: _walletController.searchController,
                            // onSaved: (value) {
                            //   _walletController.search = value!;
                            // },
                            // validator: (value) {
                            //   return _walletController.validatePhone(value!);
                            // },
                          ),
                        ),
                      ),
                      if(searchBarBigLeft == false) Container(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),

              if(isNotification == false)  if(isBack == true)  Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: (){
                      backPressed != null
                          ? backPressed!()
                          :/* Navigator.of(context).pop()*/Get.back();
                    },
                    child: const Icon(Icons.arrow_back)
                  ),

                ],
              ),
              if(isBack == false)  if(isNotification == true) Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: notificationPresses,
                    child: const Icon(Icons.notifications)
                  ),

                ],
              ),




            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff6fd3de),
                Color(0xff486ac7),
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              blurRadius: 4.0,
              spreadRadius: 1.0,
            )
          ]),
    );
  }
}
