class Request {
  final String id;
  final String type;
  final String address;
  final String?
  comment; // агрегированный текст (комментарий + срок + Электрика)
  final String status;
  final DateTime? createdAt;

  Request({
    required this.id,
    required this.type,
    required this.address,
    required this.status,
    this.comment,
    this.createdAt,
  });

  factory Request.fromJson(Map<String, dynamic> j) => Request(
    id: (j['id'] ?? '').toString(),
    type: (j['type'] ?? '').toString(),
    address: (j['address'] ?? '').toString(),
    comment: j['comment'] as String?,
    status: (j['status'] ?? 'new').toString(),
    createdAt: j['created_at'] != null
        ? DateTime.tryParse(j['created_at'].toString())
        : null,
  );
}
