class Bookmark {
  final int? id;
  final String name;
  final String url;
  final DateTime date;

  Bookmark({
    this.id,
    required this.name,
    required this.url,
    required this.date,
  });

  factory Bookmark.create({required String name, required String url}) {
    return Bookmark(id: null, name: name, url: url, date: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'url': url, 'date': date.toIso8601String()};
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      id: map['id'] as int?,
      name: map['name'] as String,
      url: map['url'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
