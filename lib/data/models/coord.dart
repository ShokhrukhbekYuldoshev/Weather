class Coord {
  final double lat;
  final double lon;

  Coord({required this.lat, required this.lon});

  // empty coord
  factory Coord.empty() {
    return Coord(lat: 0, lon: 0);
  }

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lat: json['lat'].toDouble(), lon: json['lon'].toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lon': lon};
  }
}
