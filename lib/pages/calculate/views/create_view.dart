import 'package:bloc_tutor/pages/calculate/provider/calculate_provider.dart';
import 'package:bloc_tutor/pages/main/widgets/custom_input.dart';
import 'package:bloc_tutor/utils/formatters/summa.dart';
import 'package:bloc_tutor/utils/formatters/uzb_phone.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculateProvider>(builder: (context, calculateProvider, _) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: calculateProvider.name,
                  hintText: "Ism",
                  action: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: calculateProvider.secondName,
                  hintText: "Familiya",
                  action: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16.0),
                const Text(
                  "+998",
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: CustomInput(
                    controller: calculateProvider.phone,
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                    formatters: [
                      UzbekPhoneNumberFormatter(),
                    ],
                    hintText: "90-290-2614",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: calculateProvider.summa,
                  hintText: "Summa",
                  keyboardType: TextInputType.number,
                  formatters: [
                    SummaFormatter(),
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
                          "Qo'shish",
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
