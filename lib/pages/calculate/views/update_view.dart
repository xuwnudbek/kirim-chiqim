import 'package:bloc_tutor/pages/calculate/provider/calculate_provider.dart';
import 'package:bloc_tutor/pages/calculate/widgets/payment_tile.dart';
import 'package:bloc_tutor/pages/main/widgets/custom_input.dart';
import 'package:bloc_tutor/utils/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculateProvider>(builder: (context, calculateProvider, _) {
      return Column(
        children: [
          //User's name
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${calculateProvider.userData.user.name} ${calculateProvider.userData.user.secondName ?? ""}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          //Debt & Payment
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(50),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${calculateProvider.userData.jamiOlinganQarzlar} so'm",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(50),
                    // borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${calculateProvider.userData.jamiTulanganQarzlar} so'm",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          //Input for New Payment || New Debt
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: calculateProvider.summa,
                  hintText: "Summa",
                  formatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  color: calculateProvider.isQarz ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  calculateProvider.isQarzValue = !calculateProvider.isQarz;
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: calculateProvider.isQarz ? Colors.red.withAlpha(50) : Colors.green.withAlpha(50),
                  ),
                  child: calculateProvider.isQarz
                      ? const Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          //Save button
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    await calculateProvider.save();
                  },
                  style: TextButton.styleFrom(
                    shape: const LinearBorder(),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(50, 50),
                    maximumSize: const Size(50, 50),
                  ),
                  child: calculateProvider.isSaving
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Saqlash",
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: calculateProvider.userData.qarzlar.length,
              itemBuilder: (context, index) {
                return PaymentTile(index: index);
              },
            ),
          ),
        ],
      );
    });
  }
}
