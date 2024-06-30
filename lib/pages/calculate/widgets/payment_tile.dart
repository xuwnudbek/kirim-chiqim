import 'package:bloc_tutor/pages/calculate/provider/calculate_provider.dart';
import 'package:bloc_tutor/utils/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculateProvider>(builder: (context, calculateProvider, _) {
      var hisobKitob = calculateProvider.userData.qarzlar[index];
      bool isQarz = hisobKitob['is_qarz'] ?? false;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.5,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            backgroundColor: isQarz ? Colors.red.shade50 : Colors.green.shade50,
            child: Icon(
              isQarz ? Icons.arrow_upward : Icons.arrow_downward,
              color: isQarz ? Colors.red : Colors.green,
            ),
          ),
          title: Text(
            "${hisobKitob['amount']} so'm",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isQarz ? Colors.red : Colors.green,
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 4.0),
              Text(
                DateTime.parse(hisobKitob['date']).toDMY,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                DateTime.parse(hisobKitob['date']).toHM,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
