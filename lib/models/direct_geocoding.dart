import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  const DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  DirectGeocoding copyWith({
    String? name,
    double? lat,
    double? lon,
    String? country,
  }) {
    return DirectGeocoding(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'lat': lat});
    result.addAll({'lon': lon});
    result.addAll({'country': country});

    return result;
  }

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      name: data['name'] ?? '',
      lat: data['lat']?.toDouble() ?? 0.0,
      lon: data['lon']?.toDouble() ?? 0.0,
      country: data['country'] ?? '',
    );
  }

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lat: $lat, lon: $lon, country: $country)';
  }

  @override
  List<Object> get props => [name, lat, lon, country];
}
