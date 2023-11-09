

import 'package:flutter/material.dart';

resignKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}


Widget columnSpace(double space) {
  return SizedBox(
    height: space,
  );
}


Widget rowSpace(double space) {
  return SizedBox(
    width: space,
  );
}
