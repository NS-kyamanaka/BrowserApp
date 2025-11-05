import 'package:browser_app/providers/favicon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favicon extends ConsumerWidget {
  final String url;
  final double size;

  const Favicon({super.key, required this.url, this.size = 24.0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faviconAsyncValue = ref.watch(faviconUrlProvider(url));

    return SizedBox(
      width: size,
      height: size,
      child: faviconAsyncValue.when(
        data: (faviconUrl) {
          if (faviconUrl != null) {
            return Image.network(
              faviconUrl,
              width: size,
              height: size,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.public, size: size),
            );
          }
          return Icon(Icons.link, size: size);
        },
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
        error: (err, stack) => Icon(Icons.error, size: size),
      ),
    );
  }
}
