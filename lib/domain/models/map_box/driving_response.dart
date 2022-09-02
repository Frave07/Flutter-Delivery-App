
class DrivingResponse {

  final List<Route> routes;
  final List<Waypoint> waypoints;
  final String code;
  final String uuid;
  
  DrivingResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  factory DrivingResponse.fromJson(Map<String, dynamic> json) => DrivingResponse(
    routes: json["routes"] != null ? List<Route>.from(json["routes"].map((x) => Route.fromJson(x))) : [],
    waypoints: json["waypoints"] != null ? List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))) : [],
    code: json["code"] ?? '',
    uuid: json["uuid"] ?? '',
  );
}

class Route {
    
  final String weightName;
  final double weight;
  final double duration;
  final double distance;
  final List<Leg> legs;
  final String geometry;

  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    weightName: json["weight_name"],
    weight: json["weight"].toDouble(),
    duration: json["duration"].toDouble(),
    distance: json["distance"].toDouble(),
    legs: json["legs"] != null ? List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))) : [],
    geometry: json["geometry"],
  );
}

class Leg {

  final List<dynamic> viaWaypoints;
  final List<Admin> admins;
  final double weight;
  final double duration;
  final List<dynamic> steps;
  final double distance;
  final String summary;
  
  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    viaWaypoints: json["via_waypoints"] != null ? List<dynamic>.from(json["via_waypoints"].map((x) => x)) : [],
    admins: json["admins"] != null ? List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))) : [],
    weight: json["weight"].toDouble(),
    duration: json["duration"].toDouble(),
    steps: json["steps"] != null ? List<dynamic>.from(json["steps"].map((x) => x)) : [],
    distance: json["distance"].toDouble(),
    summary: json["summary"] ?? '',
  );

}

class Admin {

  final String iso31661Alpha3;
  final String iso31661;
  
  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    iso31661Alpha3: json["iso_3166_1_alpha3"] ?? '',
    iso31661: json["iso_3166_1"] ?? '',
  );
}

class Waypoint {

  final double distance;
  final String name;
  final List<double> location;

  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
    distance: json["distance"].toDouble(),
    name: json["name"],
    location: json["location"] != null ? List<double>.from(json["location"].map((x) => x.toDouble())) : [],
  );
}
