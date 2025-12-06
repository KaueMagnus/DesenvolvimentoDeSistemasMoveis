class Launch {
  final String id;
  final String name;
  final String? details;
  final String? patchImage;
  final bool? success;

  Launch({
    required this.id,
    required this.name,
    this.details,
    this.patchImage,
    this.success,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      patchImage: json['links']?['patch']?['small'],
      success: json['success'],
    );
  }
}