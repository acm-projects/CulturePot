import 'package:culture_pot/culture_feed.dart';
import 'package:culture_pot/services/culture_description';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Idiom {
  String originalPhrase;
  String translation;
  List<String> exampleSentences;

  Idiom({
    required this.originalPhrase,
    required this.translation,
    required this.exampleSentences,
  });

  // Factory constructor to create an Idiom instance from a Firestore document
  factory Idiom.fromFirestore(Map<String, dynamic> data) {
    return Idiom(
      originalPhrase: data['originalPhrase'] ?? '',
      translation: data['translation'] ?? '',
      exampleSentences: List<String>.from(data['exampleSentences'] ?? []),
    );
  }

  // Method to convert the Idiom instance to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'originalPhrase': originalPhrase,
      'translation': translation,
      'exampleSentences': exampleSentences,
    };
  }

  // Helper method to add an example sentence to the list
  void addExampleSentence(String sentence) {
    exampleSentences.add(sentence);
  }

  // Helper method to remove an example sentence from the list
  void removeExampleSentence(String sentence) {
    exampleSentences.remove(sentence);
  }
}

