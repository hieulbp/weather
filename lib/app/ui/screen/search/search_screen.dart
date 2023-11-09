
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weather/app/controller/home/home_controller.dart';
import 'package:weather/app/data/model/search_response.dart';

import '../../../../manager/setting_manager.dart';
import '../../../controller/search/search_controller.dart' as my;
import '../../../data/model/forescast_response.dart';
import '../../../util/extendsion.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_theme.dart';
import '../widget/empty_widget.dart';

class SearchScreen extends GetView<my.SearchController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion(
        value: styleWithSimpleNavigationBar,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              decoration: BoxDecoration(
                  color: backgroundColor,
              ),
              child: Column(
                children: [


                  Obx(()=> SettingManager.shared.isConnected.isTrue ? SizedBox.shrink() :  Text('Check your internet connection'.tr, style: fontQuicksand_Medium(14, color: Colors.red), textAlign: TextAlign.center,),),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){

                            Get.back();

                          }, child: SvgPicture.asset('assets/images/icon_back.svg', width: 20, height: 20, color: textColorBlack,)),

                      Expanded(child: Text('Search'.tr, style: fontQuicksand_Bold(16, color: textColorBlack), textAlign: TextAlign.center,)),

                      Container(width: 30, height: 20,)

                    ],
                  ),

                  columnSpace(20),

                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(28)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        rowSpace(24),

                        SvgPicture.asset('assets/images/icon_search.svg', color: textColorBlack,),

                        rowSpace(12),

                        Expanded(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                controller.hasSearchFocus = hasFocus;
                              },
                              child: CupertinoTextField(
                                style: fontQuicksand_Regular(16, color: textColorBlack),
                                keyboardType: TextInputType.text,
                                controller: controller.editController,
                                onChanged: (v){
                                  controller.onSearchChanged(v);
                                },
                                placeholder: 'City, US Zipcode, IP address, Latitude/Longitude'.tr,
                                placeholderStyle: fontQuicksand_Regular(16, color: textColorBlack),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.transparent, width: 0)
                                ),
                                clearButtonMode: OverlayVisibilityMode.editing,
                                textAlign: TextAlign.start,
                              ),

                            )
                        ),

                        rowSpace(6),
                      ],
                    ),
                  ),


                  columnSpace(20),

                  Expanded(
                    child: Obx(()=>controller.listLocation.isNotEmpty ? ListView.separated(
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return rowCity(controller.listLocation[index]);
                        },
                        separatorBuilder: (context, index) => Divider(height: 0.1, thickness: 0.1, color: Colors.grey,),
                        itemCount: controller.listLocation.length
                    ) : emptyIndicatorWidget()),
                  ),




                ],
              )
          ),
        ));
  }

  Widget rowCity(SearchResponse location) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () async {

        Get.find<HomeController>().clearData();
        Get.find<HomeController>().getDataForecast(q: location.name);

        Get.back();
      },
      child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              columnSpace(10),

              Text(location.country ?? '', style: fontQuicksand_Semibold(14, color: textColorBlack), overflow: TextOverflow.ellipsis,),

              columnSpace(4),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Expanded(
                    child:  Text(location.name ?? '', style: fontQuicksand_Medium(14, color: textColorBlack), overflow: TextOverflow.ellipsis,),

                  ),

                  rowSpace(8),

                ],
              ),

              columnSpace(10)

            ],
          )
      ),
    );

  }



}