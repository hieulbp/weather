
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../controller/detail/details_controller.dart';
import '../../theme/app_colors.dart';

class DetailsScreen extends GetView<DetailsController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Container()

      ),
    );
  }

}