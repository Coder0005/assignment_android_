class NotiFication {
  var title;
  var description;
  var about;

  NotiFication(this.title, this.description, this.about);

  NotiFication.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': description, 'about': about};
}
