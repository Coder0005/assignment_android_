import 'dart:developer';

import 'package:freelancer_app/db/const.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);

    await collection.insertOne(
        {"username": "aryan1", "fname": "aryan", "lname": "pokharel"});
    print(await collection.find().toList());
  }
}
