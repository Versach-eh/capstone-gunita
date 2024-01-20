import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  String id;
  String imageUrl;
  String textInfo;

  ImageModel({required this.id, required this.imageUrl, required this.textInfo});

  // Factory method to create an ImageModel instance from a Firestore document
  factory ImageModel.fromDocument(DocumentSnapshot document) {
    if (document.exists) {
      return ImageModel(
        imageUrl: document['imageUrl'],
        id: document['albumId'],
        textInfo: document['textInfo']
      );
    } else {
      // Handle the case where the document does not exist
      return ImageModel(
        imageUrl: 'defaultImageUrl', // Provide a default value or handle accordingly
        id: 'defaulId',
        textInfo: 'defaultTextInfo'
      );
    }
  }
}