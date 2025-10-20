import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:browser_app/data/models/bookmark.dart';
import 'package:flutter_riverpod/legacy.dart';

enum SortDirection { asc, desc }

final sortDirectionProvider = StateProvider<SortDirection>(
  (ref) => SortDirection.asc,
);

final sortedAndFilteredBookmarkListProvider = Provider<List<Bookmark>>((ref) {
  final filteredList = ref.watch(filteredBookmarkListProvider);
  final direction = ref.watch(sortDirectionProvider);

  final sortedList = List<Bookmark>.from(filteredList);

  if (direction == SortDirection.desc) {
    sortedList.sort((a, b) => b.date.compareTo(a.date));
  } else {
    sortedList.sort((a, b) => a.date.compareTo(b.date));
  }
  
  return sortedList;
});
