// import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart';

// class ProductAPI{
//   Future<bool> addProduct(File? file) async {
//     try {
//       var url = baseUrl + productUrl;
//       var dio = HttpServices().getDioInstance();
//       MultipartFile? image;
//       if (file != null){
//         var mimeType = lookupMimeType(file.path);

//         image = await MultipartFile.fromFile(file.path,
//         filename : file.path.split("/").last,
//         contentType : MediaType("image", mimeType!.split("/")[1]),);
//       }
//       var formData = FormData.fromMap({
//         "name" : "test",
//         "description" : "test",
//         "image" : image,
//         "price" : "234",
//         "category" : "theProductId",
//         "countInStock" : "2",
//         "rating" : "3",
//         "numReviews" : "3",
//         "isFeatured" : "false",
//       },);

//       var response = await

//     }
//   }
// }