import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_212/data/models/rating.dart';
import 'rating_controller.dart';

class RatingView extends StatelessWidget {
  final String rideId;
  final String driverId;
  final String customerId;

  RatingView({
    super.key,
    required this.rideId,
    required this.driverId,
    required this.customerId,
  });

  RatingController controller = Get.put(RatingController());
  final RxDouble selectedRating = 0.0.obs;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("تقييم السائق"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < selectedRating.value
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    onPressed: () => selectedRating.value = index + 1.0,
                  );
                }),
              )),
          TextField(
            controller: commentController,
            decoration:
                const InputDecoration(labelText: "اكتب تعليقك (اختياري)"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: () {
            controller.addRating(Rating(
              rideId: rideId,
              driverId: driverId,
              customerId: customerId,
              rating: selectedRating.value,
              comment: commentController.text,
            ));
            Get.back();
          },
          child: const Text("إرسال"),
        ),
      ],
    );
  }
}
