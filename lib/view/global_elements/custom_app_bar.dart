import 'package:flutter/material.dart';

import '../../utils/constants.dart';

AppBar CustomAppBar({required Widget title, List<Widget>? actions}) => AppBar(
  backgroundColor: AppColor.primary,
  elevation: 4,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
  ),
  centerTitle: true,
  title: title,
  actions: actions ?? [],
);
