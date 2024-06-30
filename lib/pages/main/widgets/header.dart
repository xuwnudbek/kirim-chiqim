import 'package:bloc_tutor/pages/main/provider/main_provider.dart';
import 'package:bloc_tutor/pages/main/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, mainProvider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            const SizedBox(width: 16.0),
            Expanded(
              child: CustomInput(
                controller: mainProvider.searchController,
                hintText: "Qidirish...",
              ),
            ),
            const SizedBox(width: 16.0),
            InkWell(
              onTap: () {
                mainProvider.selectDateRange(context);
              },
              child: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
