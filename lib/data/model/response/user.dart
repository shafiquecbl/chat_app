// ignore_for_file: file_names

class AppUser {
  AppUser(
      {this.name,
      this.email,
      this.password,
      this.image,
      this.city,
      this.contacts,
      this.country,
      this.dob,
      this.gender,
      this.infoVisibility,
      this.interests,
      this.rating,
      this.ratingCount,
      this.token});
  String? name, email, password, image, gender, dob, country, city, token;
  double? rating, ratingCount;
  List<String>? interests, contacts;
  bool? infoVisibility;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        image: json['image'],
        gender: json['gender'],
        dob: json['dob'],
        country: json['country'],
        city: json['city'],
        token: json['token'],
        rating: double.parse(json['rating'].toString()),
        ratingCount: double.parse(json['ratingCount'].toString()),
        interests: List<String>.from(json['interests'].map((x) => x)),
        contacts: List<String>.from(json['contacts'].map((x) => x)),
        infoVisibility: json['infoVisibility'],
      );

  Map<String, dynamic> toJson() => {
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
        'contacts': contacts == null
            ? null
            : List<dynamic>.from(contacts!.map((x) => x)),
        'infoVisibility': infoVisibility,
      };
}
