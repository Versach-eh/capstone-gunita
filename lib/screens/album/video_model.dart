import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String id;
  String videoUrl;
  String title; // Add title
  String description; // Add description
  String thumbnailUrl;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  // Factory method to create a VideoModel instance from a Firestore document
  factory VideoModel.fromDocument(DocumentSnapshot document) {
    if (document.exists) {
      return VideoModel(
        videoUrl: document['videoUrl'],
        id: document.id,
        title: document['title'] ?? 'Default Title',
        description: document['description'] ?? 'Default Description',
        thumbnailUrl: document['thumbnailUrl'] ?? 'Default Thumbnail URL',
      );
    } else {
      // Handle the case where the document does not exist
      return VideoModel(
        videoUrl: 'defaultVideoUrl',
        id: 'defaultId',
        title: 'Default Title',
        description: 'Default Description',
        thumbnailUrl: 'defaultThumbnailUrl',
      );
    }
  }
}
