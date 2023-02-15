class Hiring {
  var client;
  var worker;
  var gig;

  Hiring(this.client, this.worker, this.gig);

  Hiring.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    worker = json['worker'];
    gig = json['gig'];

    Map<String, dynamic> toJson() => {
          'client': client,
          'worker': worker,
          'gig': gig,
        };
  }
}

 

// factory User.fromJson(Map<String,dynamic> json)=> _$UserFromJson(json);



// Map<String,dynamic> toJson() => _$UserToJson(this);





// }