import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/app_theme.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class HomeView extends AppView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, HomeController controller) {
    final isSearching = controller.isSearching.watch(context);

    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.profile),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF252637),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
        title: isSearching
            ? TextField(
                autofocus: true,
                onChanged: controller.search.set,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Search watch parties...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xFF6B6B7B)),
                ),
              )
            : ShaderMask(
                shaderCallback: (bounds) =>
                    LinearGradient(
                      colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    ),
                child: const Text('Roomy'),
              ),
        actions: [
          if (isSearching)
            IconButton(
              onPressed: () {
                controller.isSearching.set(false);
                controller.search.set('');
              },
              icon: const Icon(Icons.close_rounded),
            )
          else
            IconButton(
              onPressed: () => controller.isSearching.set(true),
              icon: const Icon(Icons.search_rounded),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF252637),
                shape: const CircleBorder(),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await controller.getPublicRooms(),
          child: CustomScrollView(
            slivers: [
              // Rooms List
              controller.filteredRooms.watch(context).isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: _EmptyState()),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final rooms = controller.filteredRooms.watch(
                              context,
                            );
                            final room = rooms[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: FutureBuilder(
                                future: controller.getUser(room.hostId),
                                builder: (context, snapshot) {
                                  final hostUsername =
                                      snapshot.data?.username ?? 'Unknown';
                                  return _RoomCard(
                                    name: room.name,
                                    host: hostUsername,
                                    id: room.id,
                                    index: index,
                                  );
                                },
                              ),
                            );
                          },
                          childCount: controller.filteredRooms
                              .watch(context)
                              .length,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: PulsingFab(
        onPressed: () => context.push(AppRoutes.selectPlatform),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            color: Color(0xFF252637),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.movie_outlined,
            size: 56,
            color: Color(0xFF6B6B7B),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "No watch parties yet",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Create one and invite your friends!",
          style: TextStyle(fontSize: 14, color: Color(0xFF6B6B7B)),
        ),
      ],
    );
  }
}

class _RoomCard extends StatelessWidget {
  final String name;
  final String host;
  final String id;
  final int index;

  const _RoomCard({
    required this.name,
    required this.host,
    required this.id,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xFF6C5CE7),
      Color(0xFFFF6B9D),
      Color(0xFF2ECC71),
      Color(0xFFFF8C42),
    ];
    final color = colors[index % colors.length];

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1F1F2E),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.pushReplacement('/room/$id'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                height: 170,
                decoration: BoxDecoration(color: Color(0xFF2A2B3D)),
                child: Stack(
                  children: [
                    // Background gradient
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withValues(alpha: 0.25),
                              color.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Play icon
                    Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Room Title
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // Host info
                    Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xFF2E2F3E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "by $host",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B6B7B),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Small play circle (right side)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: color,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PulsingFab extends StatefulWidget {
  final VoidCallback onPressed;
  final double minScale;
  final double maxScale;
  final Duration duration;
  final Curve curve;

  const PulsingFab({
    super.key,
    required this.onPressed,
    this.minScale = 1.0,
    this.maxScale = 1.08,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
  });

  @override
  State<PulsingFab> createState() => _PulsingFabState();
}

class _PulsingFabState extends State<PulsingFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: Colors.transparent,
          elevation: 6,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded, size: 32),
        ),
      ),
    );
  }
}
