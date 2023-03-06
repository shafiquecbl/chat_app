// ignore_for_file: file_names

class AppUser {
  AppUser(
      {this.name,
      this.id,
      this.email,
      this.password,
      this.image,
      this.city,
      this.country,
      this.dob,
      this.gender,
      this.infoVisibility,
      this.interests,
      this.rating,
      this.ratingCount,
      this.token,
      this.isOnline});
  String? id, name, email, password, image, gender, dob, country, city, token;
  double? rating, ratingCount;
  List<String>? interests;
  bool? infoVisibility;
  bool? isOnline;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        image: json['image'],
        gender: json['gender'],
        dob: json['dob'],
        country: json['country'],
        city: json['city'],
        token: json['token'],
        rating: json['rating'] == null
            ? null
            : double.parse(json['rating'].toString()),
        ratingCount: json['ratingCount'] == null
            ? null
            : double.parse(json['ratingCount'].toString()),
        interests: json['interests'] == null
            ? null
            : List<String>.from(json['interests'].map((x) => x)),
        infoVisibility: json['infoVisibility'],
        isOnline: json['online'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'image': image,
        'gender': gender,
        'dob': dob,
        'country': country,
        'city': city,
        'token': token,
        'rating': rating,
        'ratingCount': ratingCount,
        'interests': List<dynamic>.from(interests!.map((x) => x)),
        'infoVisibility': infoVisibility,
      };
}
