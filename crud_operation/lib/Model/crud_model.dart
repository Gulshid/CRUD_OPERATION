class CrudModel {
  final String? id;
  final String? url;
  final double? progress;

  CrudModel({this.id, this.url, this.progress});

  CrudModel copyWith({double? progress, String? url}) => CrudModel(
    id: id,
    url: url ?? this.url,
    progress: progress ?? this.progress,
  );
}
