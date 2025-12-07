import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class HomeView extends AppView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, HomeController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roomy"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.push(AppRoutes.profile),
          icon: const Icon(Icons.person_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () async => await controller.getPublicRooms(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.people_rounded)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                onChanged: controller.search.set,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: "Search",
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.filteredRooms.watch(context).length,
                  itemBuilder: (context, index) {
                    final room = controller.filteredRooms.watch(context)[index];
                    return FutureBuilder(
                      future: controller.getUser(room.hostId),
                      builder: (context, snapshot) {
                        final hostUsername =
                            snapshot.data?.username ?? 'Unknown';
                        return _buildRoomItem(
                          context,
                          room.name,
                          hostUsername,
                          room.id,
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.createRoom),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRoomItem(
    BuildContext context,
    String title,
    String subtitle,
    String roomId,
  ) {
    return Card(
      child: InkWell(
        borderRadius: .circular(12),
        onTap: () => context.pushReplacement('/room/$roomId'),
        child: Padding(
          padding: .all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color:
                            Theme.of(context).textTheme.labelMedium?.color
                                ?.withValues(alpha: 0.7) ??
                            Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
