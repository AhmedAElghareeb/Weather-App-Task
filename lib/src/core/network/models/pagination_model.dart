class PaginationModel {
  final int? total;
  final int? count;
  final int? perPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int? currentPage;
  final int? totalPages;

  PaginationModel({
    this.total,
    this.count,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.currentPage,
    this.totalPages,
  });

  PaginationModel copyWith({
    int? total,
    int? count,
    int? perPage,
    String? nextPageUrl,
    String? prevPageUrl,
    int? currentPage,
    int? totalPages,
  }) {
    return PaginationModel(
      total: total ?? this.total,
      count: count ?? this.count,
      perPage: perPage ?? this.perPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        total: json['total'],
        count: json['count'],
        perPage: json['per_page'],
        nextPageUrl: json['next_page_url'],
        prevPageUrl: json['prev_page_url'],
        currentPage: json['current_page'],
        totalPages: json['total_pages'],
      );
}
