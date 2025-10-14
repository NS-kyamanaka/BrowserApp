import 'package:browser_app/data/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/models/bookmark.dart';

final bookmarkRepositoryProvider = Provider((ref) => BookmarkRepository());

class BookmarkNotifier extends StateNotifier<List<Bookmark>> {
  final BookmarkRepository _repository;

  BookmarkNotifier(this._repository) : super([]);

  Future<void> loadBookmarks() async {
    await _repository.open();
    final bookmarks = await _repository.getBookmarks();
    state = bookmarks;
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    final newId = await _repository.insertBookmark(bookmark);
    final newBookmark = Bookmark(
      id : newId,
      name : bookmark.name,
      url: bookmark.url,
      date: bookmark.date,
    );
    state = [...state, newBookmark];
  }
}

final bookmarkListProvider =
    StateNotifierProvider<BookmarkNotifier, List<Bookmark>>((ref) {
      final repository = ref.watch(bookmarkRepositoryProvider);
      return BookmarkNotifier(repository);
    });
