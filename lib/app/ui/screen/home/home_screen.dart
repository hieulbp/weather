
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather/app/data/model/forecast_day.dart';
import 'package:weather/app/data/model/hour.dart';
import 'package:weather/app/util/extendsion.dart';

import '../../../../manager/setting_manager.dart';
import '../../../controller/home/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_theme.dart';
import '../widget/radio_widget.dart';


class HomeScreen extends GetView<HomeController>{

  HomeScreen(){

    controller.getDataForecast();

  }
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
                gradient: controller.checkNight()
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

                        controller.getDataLocal();

                        _dialogSetting();

                      }, child: SvgPicture.asset('assets/images/icon_setting.svg', width: 20, height: 20, color: textColor,)),

                    Obx(()=> Expanded(child: Text(controller.cityName.value, style: fontQuicksand_Bold(16), textAlign: TextAlign.center,)),),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){

                          Get.toNamed(Routes.SEARCH);

                        }, child: SvgPicture.asset('assets/images/icon_search.svg', width: 20, height: 20, color: textColor)),


                  ],
                ),

                columnSpace(20),

                Obx(()=>Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(controller.showMessageWelcome(), style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis, maxLines: 2,),

                                    columnSpace(10),

                                   Obx(()=> Text('${controller.temp.value}°', style: fontQuicksand_Medium(100)),),

                                    Text(controller.condition.value , style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis,),
                                    columnSpace(10),

                                    Text('${'High: '.tr} ${controller.maxTemp.value}° | ${'Low: '.tr}${controller.minTemp.value}°', style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis,),


                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Container(
                                  width: 150, height: 150,
                                  child: SvgPicture.asset(controller.assetImage, width: 150, height: 150,)
                              ),
                            )
                          ],
                        ),

                        columnSpace(20),

                        Container(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              reverse: false,
                              itemBuilder: (context, index) {
                                return itemHour(index, controller.currentForecast.value.forecast?.forecastday?.first.hour?[index]);
                              },

                              itemCount: controller.currentForecast.value.forecast?.forecastday?.first.hour?.length ?? 0),
                        ),

                        columnSpace(10),

                        ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return itemDate(index, controller.currentForecast.value.forecast?.forecastday?[index]  );
                            },
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            ),
                            itemCount: controller.currentForecast.value.forecast?.forecastday?.length ?? 0),

                        columnSpace(10),

                        Row(
                          children: [
                            Expanded(child: itemHome('Sunrise'.tr, controller.currentForecast.value.forecast?.forecastday?.first.astro?.sunrise ?? ''), flex: 1,),
                            rowSpace(10),
                            Expanded(child: itemHome('Sunset'.tr, controller.currentForecast.value.forecast?.forecastday?.first.astro?.sunset ?? ''), flex: 1,)

                          ],
                        ),

                        columnSpace(10),

                        Row(
                          children: [
                            Expanded(child: itemHome('UV', controller.uv.value), flex: 1,),
                            rowSpace(10),
                            Obx(()=>Expanded(child: itemHome('Air quality'.tr, controller.airq.value), flex: 1,))

                          ],
                        ),

                        columnSpace(10),

                        Row(
                          children: [
                            Expanded(child: itemHome('Wind'.tr, controller.wind.value), flex: 1,),
                            rowSpace(10),
                            Expanded(child: itemHome('Feel like'.tr, controller.tempFeel.value + '°'), flex: 1,)

                          ],
                        ),

                        columnSpace(10),


                      ],
                    ),
                  ),
                ),)




              ],
            )
        ),
    ));
  }

  Widget itemHome(String title, String value) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: itemHourColorBG,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: fontQuicksand_Medium(14, color: textColor), overflow: TextOverflow.ellipsis,),


          Text(value, style: fontQuicksand_Bold(22), overflow: TextOverflow.ellipsis,),

        ],
      ),
    );

  }

  Widget itemHour(int index, Hour? hour) {

    var temp = '-/-';
    var assetImage = 'assets/images/day/113.svg';

    if(SettingManager.shared.typeTemp == 0){
      temp = hour?.tempC?.toStringAsFixed(0) ?? '';

    } else {
      temp = hour?.tempF?.toStringAsFixed(0) ?? '';


    }

    String result = controller.extractValueFromUrl(hour?.condition?.icon ?? '');
    print(result);

    assetImage = 'assets/images${result}.svg';

    var date = DateTime.parse(hour?.time ?? '');
    print(date.hour.toString());

    var now = DateTime.now();

    if(date.hour < now.hour) return SizedBox.shrink();

    return Container(
      width: 50,
      height: 120,
      margin: EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        color: itemHourColorBG,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date.hour.toString() + 'h'.tr, style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis,),

          columnSpace(10),

          SvgPicture.asset(assetImage, width: 30, height: 30,),


          columnSpace(10),

          Text('$temp°', style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis,),

        ],
      ),
    );

  }

  Widget itemDate(int index, Forecastday? forecastday) {

    var tempMin = '-/-';
    var tempMax = '-/-';

    var assetImage = 'assets/images/day/113.svg';

    if(SettingManager.shared.typeTemp == 0){
      tempMin = forecastday?.day?.mintempC?.toStringAsFixed(0) ?? '';
      tempMax = forecastday?.day?.maxtempC?.toStringAsFixed(0) ?? '';

    } else {
      tempMin = forecastday?.day?.mintempF?.toStringAsFixed(0) ?? '';
      tempMax = forecastday?.day?.maxtempF?.toStringAsFixed(0) ?? '';

    }

    String result = controller.extractValueFromUrl(forecastday?.day?.condition?.icon ?? '');
    print(result);

    assetImage = 'assets/images${result}.svg';

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: itemHourColorBG,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          rowSpace(10),

          Expanded(
            flex: 1,
              child: Text(index == 0 ? 'Today'.tr : index == 1 ? 'Tomorrow'.tr : forecastday?.date.toString() ?? '', style: fontQuicksand_Medium(14), overflow: TextOverflow.ellipsis,)),


          Expanded(flex: 1, child: SvgPicture.asset(assetImage, width: 30, height: 30,)),


          Expanded(child: Text( tempMin + '°', style: fontQuicksand_Bold(14), overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,)),

          rowSpace(10),

          Text(tempMax + '°', style: fontQuicksand_Bold(14), overflow: TextOverflow.ellipsis,),

          rowSpace(10),

        ],
      ),
    );
  }


  _dialogSetting(){
    showCupertinoDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (context){
          return Container(
            margin: EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, -2), // changes position of shadow
                  ),
                ]
            ),
            child: Column(
              children: [
                columnSpace(20),

                Row(
                  children: [
                    rowSpace(40),

                    Expanded(
                      child: Center(
                        child: Material(
                          child: Text(
                            'Setting'.tr,
                            style: fontQuicksand_Bold(16, color: textColorBlack),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        child: SvgPicture.asset('assets/images/icon_close.svg', width: 12, height: 12,)
                    ),

                  ],
                ),

                columnSpace(20),

                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [


                        Material(
                          child: Text(
                            'Language'.tr,
                            style: fontQuicksand_Bold(14, color: textColorBlack),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        columnSpace(10),

                        radioBox('Vietnamese'.tr, controller.isVietnamese, (p0) {
                          controller.isVietnamese..value = p0..refresh();
                          controller.isEnglish..value = !p0..refresh();
                        }),


                        radioBox('English'.tr, controller.isEnglish, (p0) {
                          controller.isEnglish..value = p0..refresh();
                          controller.isVietnamese..value = !p0..refresh();
                        }),


                        columnSpace(20),


                      ],
                    )
                ),

                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [


                        Material(
                          child: Text(
                            'Temperature'.tr,
                            style: fontQuicksand_Bold(14, color: textColorBlack),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        columnSpace(10),

                        radioBox('°C'.tr, controller.isTempC, (p0) {
                          controller.isTempC..value = p0..refresh();
                          controller.isTempF..value = !p0..refresh();
                        }),


                        radioBox('°F'.tr, controller.isTempF, (p0) {
                          controller.isTempF..value = p0..refresh();
                          controller.isTempC..value = !p0..refresh();
                        }),


                        columnSpace(20),


                      ],
                    )
                ),
                columnSpace(10),

                Expanded(child: SizedBox()),

                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {

                    await controller.saveSetting();
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        gradient: controller.checkNight(),
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child: Center(
                      child: Text(
                        'Apply'.tr,
                        style: fontQuicksand_Bold(14),
                        textAlign: TextAlign.center,
                      )
                    ),
                  ),
                ),

                columnSpace(30)
              ],
            ),
          );
        }
    );
  }

}

