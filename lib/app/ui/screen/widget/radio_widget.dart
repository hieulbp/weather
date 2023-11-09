
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/ui/theme/app_colors.dart';
import 'package:weather/app/ui/theme/app_text_theme.dart';

import '../../../util/extendsion.dart';

Widget radioBox(String caption, RxBool initialCheckingStatus, Function(bool) action, {TextStyle? captionStyle}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      if (!initialCheckingStatus.value) {
        initialCheckingStatus.toggle().refresh();
        action(initialCheckingStatus.value);
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.blue)
          ),
          child: Obx(() => initialCheckingStatus.value ?
          Center(
            child: Container(
              width: 10, height: 10,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ) :
          const SizedBox()),
        ),

        rowSpace(12),

        Text(
          caption,
          style: captionStyle ?? fontQuicksand_Regular(14, color: textColorBlack),
          maxLines: 5,
        ),
      ],
    ),
  );
}
