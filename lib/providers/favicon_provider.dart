import 'package:flutter_riverpod/flutter_riverpod.dart';

final faviconUrlProvider = FutureProvider.family<String?, String>((ref, url) async {
  final uri = Uri.tryParse(url);
  
  if(uri == null || !uri.hasAbsolutePath){
    return null;
  }

  final domain = uri.host;
  return 'https://www.google.com/s2/favicons?domain=$domain&sz=64';
});