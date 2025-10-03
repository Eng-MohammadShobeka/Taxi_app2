import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';

class AdminDashboardView extends GetView<AdminController> {
  AdminDashboardView({super.key});
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم المدير"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshStats(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildStatCard(
                        "عدد المستخدمين",
                        controller.totalUsers.value.toString(),
                        Icons.people,
                        Colors.blueAccent, 
                        () => _showUsersDialog(context),
                      ),
                      _buildStatCard(
                        "عدد السائقين",
                        controller.totalDrivers.value.toString(),
                        Icons.drive_eta,
                        Colors.green, 
                        () => _showDriversDialog(context),
                      ),
                      _buildStatCard(
                        "عدد الرحلات",
                        controller.totalRides.value.toString(),
                        Icons.local_taxi,
                        Colors.orange,
                        null,
                      ),
                      _buildStatCard(
                        "التقييمات",
                        controller.averageRating.value.toStringAsFixed(1),
                        Icons.star,
                        Colors.amber, 
                        () => _showRatingsDialog(context),
                      ),
                      _buildStatCard(
                        "الشكاوى",
                        controller.complaints.length.toString(),
                        Icons.report_problem,
                        Colors.deepPurple, 
                        () => _showComplaintsDialog(context),
                      ),
                      _buildStatCard(
                        "التقارير المالية",
                        "\$${controller.totalEarnings.value.toStringAsFixed(2)}",
                        Icons.attach_money,
                        Colors.teal, 
                        () => _showFinanceDialog(context),
                      ),
                    ].map((card) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 48) / 2,
                          child: card,
                        )).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color,
      VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        color: color.withOpacity(0.85),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(value,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 5),
              Text(title,
                  style:
                      const TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  // ================= Dialogs ===================

  void _showDriversDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("قائمة السائقين",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.drivers.length,
                    itemBuilder: (context, index) {
                      final driver = controller.drivers[index];
                      final statusColor =
                          driver.isOnline ? Colors.green : Colors.red;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: statusColor,
                            child: Icon(
                              driver.isOnline ? Icons.check : Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(driver.name),
                          subtitle: Text("نوع السيارة: ${driver.carType}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  void _showUsersDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("قائمة المستخدمين",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.person, color: Colors.blue),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  void _showRatingsDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("تقييمات السائقين",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.drivers.length,
                    itemBuilder: (context, index) {
                      final driver = controller.drivers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(driver.name),
                          subtitle: Text(
                              "تقييم: ${driver.rating.toStringAsFixed(1)} ⭐"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  void _showComplaintsDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("الشكاوى",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = controller.complaints[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(complaint.title),
                          subtitle: Text(complaint.description),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  void _showFinanceDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("التقارير المالية",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.financialReports.length,
                    itemBuilder: (context, index) {
                      final report = controller.financialReports[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(report.title),
                          subtitle:
                              Text("المبلغ: \$${report.amount.toStringAsFixed(2)}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
