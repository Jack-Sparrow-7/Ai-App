import 'dart:convert';

import 'package:ai_app/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatDatasource {
  final FirebaseFirestore _firestore;
  final Dio _dio;

  ChatDatasource({required FirebaseFirestore firestore, required Dio dio})
    : _firestore = firestore,
      _dio = dio;

  String _extractJson(String input) {
    final cleaned = input
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();
    return cleaned;
  }

  Stream<List<MessageModel>> getMessages({required String uid}) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('messages')
        .orderBy('timeStamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => MessageModel.fromJson(doc)).toList(),
        );
  }

  Future<void> sendMessage({
    required String uid,
    required MessageModel message,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('messages')
          .add(message.toJson());
    } catch (e) {
      throw Exception('Firestore Exception: ${e.toString()}');
    }
  }

  Future<void> removeMessage({
    required String uid,
    required String messageId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception('Firestore Exception: ${e.toString()}');
    }
  }

  Future<void> eraseMessages({required String uid}) async {
    try {
      final ref = _firestore
          .collection('users')
          .doc(uid)
          .collection('messages');
      final snapshots = await ref.get();

      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Firestore Exception: ${e.toString()}');
    }
  }

  Future<MessageModel> getApiResponse({
    required List<MessageModel> recentMessages,
    required String currentUserMessage,
  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final url = dotenv.env['GEMINI_AI_URL'];
    if (apiKey == null || url == null) {
      throw StateError('Missing GEMINI_API_KEY or GEMINI_AI_URL in .env');
    }

    final buf = StringBuffer();
    var lastEmotion = 'neutral';
    for (final msg in recentMessages) {
      final role = msg.sender == 'user' ? 'User' : 'AI';
      buf.writeln('$role: ${msg.text}');
      if (msg.sender != 'user' && (msg.emotion ?? '').isNotEmpty) {
        lastEmotion = msg.emotion!;
      }
    }

    final body = {
      'contents': [
        {
          'role': 'user',
          'parts': [
            {
              'text':
                  'You are Lumi, a warm, emotionally intelligent AI companion. '
                  'Respond like ChatGPT — friendly, empathetic, and concise when needed.\n\n'
                  'Conversation history:\n${buf.toString()}'
                  'Last detected emotion: $lastEmotion\n\n'
                  'Current user message: $currentUserMessage\n\n'
                  'Return only JSON: {"emotion":"<emotion>","response":"<reply>"}',
            },
          ],
        },
      ],
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'x-goog-api-key': apiKey,
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      );

      final text =
          response.data?['candidates']?[0]?['content']?['parts']?[0]?['text']
              as String?;
      if (text == null || text.isEmpty) {
        throw StateError('Empty model response');
      }

      final cleaned = _extractJson(text);
      final parsed = jsonDecode(cleaned);

      return MessageModel(
        text: parsed['response'] as String? ?? '',
        sender: 'ai',
        emotion: parsed['emotion'] as String? ?? '',
        timeStamp: DateTime.now(),
      );
    } on DioException catch (e) {
      final details = e.response?.data ?? e.message;
      throw Exception('Gemini API error: $details');
    }
  }
}
