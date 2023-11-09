import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/ui/theme/app_text_theme.dart';

import '../../../util/extendsion.dart';

Widget emptyIndicatorWidget({String? title, String? content}) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        columnSpace(20),

        Text(
          title ?? 'No results found'.tr,
          style: fontQuicksand_Regular(18, color: Colors.grey),
        ),

        columnSpace(8),

        Text(
          content ?? 'We couldn\'t find what you’re looking for'.tr,
          style: fontQuicksand_Regular(14, color:Colors.grey, lineHeight: 1.3),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
