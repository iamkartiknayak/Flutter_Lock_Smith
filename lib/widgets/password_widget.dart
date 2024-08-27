import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import './build_generated_password.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('PasswordWidget build is called');
    final homeProvider = context.read<HomeProvider>();
    final (password, customPasswordEnabled) = context.select(
      (HomeProvider p) => (p.generatedPassword, p.customPasswordEnabled),
    );

    return Column(
      children: [
        Offstage(
          offstage: true,
          child: TextField(
            controller: homeProvider.controller,
            focusNode: homeProvider.focusNode,
            onChanged: homeProvider.handleKeyPress,
          ),
        ),
        Row(
          children: [
            BuildGeneratedPassword(password: password),
            IconButton(
              icon: Icon(
                customPasswordEnabled
                    ? CupertinoIcons.checkmark
                    : CupertinoIcons.square_on_square,
                color: Colors.teal,
              ),
              onPressed: () {
                customPasswordEnabled
                    ? context.read<HomeProvider>().toggleCustomPassword(false)
                    : Clipboard.setData(ClipboardData(text: password));
              },
            ),
          ],
        ),
      ],
    );
  }
}
