import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/home/controllers/select_platform_controller.dart';
import 'package:signals/signals_flutter.dart';

class SelectPlatformView extends AppView<SelectPlatformController> {
  const SelectPlatformView({super.key});

  @override
  Widget build(BuildContext context, SelectPlatformController controller) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Room')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Platform",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // Platform Grid
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _StreamingCard(
                      icon: Icon(AntDesign.youtube_fill, color: Colors.grey),
                      title: "YouTube",
                      subtitle: "Streaming",
                      isSelected:
                          controller.selectedPlatform.watch(context) ==
                          "youtube",
                      onTap: () =>
                          controller.togglePlatformSelection("youtube"),
                    ),
                    _StreamingCard(
                      icon: SvgPicture.asset(
                        "assets/logos/netflix.svg",
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      title: "Netflix",
                      subtitle: "Streaming",
                      isSelected:
                          controller.selectedPlatform.watch(context) ==
                          "netflix",
                      onTap: () =>
                          controller.togglePlatformSelection("netflix"),
                    ),
                    _StreamingCard(
                      icon: Icon(
                        FontAwesome.google_drive_brand,
                        color: Colors.grey,
                      ),
                      title: "Google Drive",
                      subtitle: "Cloud Storage",
                      isSelected:
                          controller.selectedPlatform.watch(context) == "drive",
                      onTap: () => controller.togglePlatformSelection("drive"),
                    ),
                    _StreamingCard(
                      icon: Icon(FontAwesome.globe_solid, color: Colors.grey),
                      title: "Web",
                      subtitle: "Search",
                      isSelected:
                          controller.selectedPlatform.watch(context) == "web",
                      onTap: () => controller.togglePlatformSelection("web"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // URL Text Field
                TextField(
                  controller: controller.mediaUrlController,
                  onTap: () => controller.clearPlatformSelection(),
                  decoration: InputDecoration(
                    hintText: "Or paste your media URL here",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final data = await Clipboard.getData(
                          Clipboard.kTextPlain,
                        );
                        if (data?.text != null) {
                          final text = data!.text!;
                          controller.mediaUrlController.text = text;
                          controller.mediaUrlController.selection =
                              TextSelection.fromPosition(
                                TextPosition(offset: text.length),
                              );
                        }
                      },
                      icon: Icon(Icons.paste),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Builder(
                    builder: (context) {
                      final platform = controller.selectedPlatform.watch(
                        context,
                      );
                      final mediaUrl = controller.mediaUrl.watch(context);

                      return ElevatedButton(
                        onPressed: platform.isEmpty
                            ? mediaUrl == null || mediaUrl.isEmpty
                                  ? null
                                  : () async {
                                      final room = await controller
                                          .createRoom();

                                      if (context.mounted && room != null) {
                                        context.pushReplacement(
                                          '/room/${room.id}',
                                        );
                                      }
                                    }
                            : () =>
                                  context.push('/createRoom/webview/$platform'),
                        child: controller.isLoading.watch(context)
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text("Continue"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreamingCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _StreamingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(width: 32, height: 32, child: icon),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline,
                      width: 2,
                    ),
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: theme.colorScheme.onPrimary,
                        )
                      : null,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
