// @jsonSerializable()
class Gig {
  // @JsonKey(name: '_id')
  // String? id;
  var title;
  var technique;
  var description;
  var rate;
  var image;

  Gig(this.title, this.technique, this.description, this.rate, this.image);

  // Gig.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       technique = json['technique'],
  //       description = json['description'],
  //       rate = json['rate'],
  //       image = json['image'];

  Gig.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    technique = json['technique'];
    description = json['description'];
    rate = json['rate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'technique': technique,
        'description': description,
        'rate': rate,
        'image': image,
      };
}
