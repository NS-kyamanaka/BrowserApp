import 'package:flutter_riverpod/legacy.dart';

enum ViewStyle { list, grid }

final viewStyleProvider = StateProvider<ViewStyle>((ref) => ViewStyle.list);