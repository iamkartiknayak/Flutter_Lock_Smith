import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class BreachStatusIndicator extends StatelessWidget {
  const BreachStatusIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('BreachStatusIndicator build is called');
    final homeProvider = context.read<HomeProvider>();
    final (breachStatus, checkingBreachState) = context.select(
      (HomeProvider p) => (p.breachStatus, p.checkingBreachState),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BREACH STATE',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    breachStatus,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: homeProvider.breachStatusColor,
                    ),
                  )
                ],
              ),
              homeProvider.checkingBreachState
                  ? Container(
                      height: 24.0,
                      width: 24.0,
                      margin: const EdgeInsets.only(right: 8.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.teal,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(CupertinoIcons.restart),
                      onPressed: context.read<HomeProvider>().checkBreachState,
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 4.0),
          child: Text(
            homeProvider.errorText,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
