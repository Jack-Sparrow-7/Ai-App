import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    super.messageId,
    required super.text,
    required super.sender,
    super.emotion,
    required super.timeStamp,
  });

  factory MessageModel.fromJson(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    final ts = json['timeStamp'];

    DateTime parsedTime;
    if (ts is Timestamp) {
      parsedTime = ts.toDate();
    } else if (ts is String) {
      parsedTime = DateTime.tryParse(ts) ?? DateTime.now();
    } else {
      parsedTime = DateTime.now();
    }
    return MessageModel(
      messageId: doc.id,
      text: json['text'] ?? '',
      sender: json['sender'] ?? '',
      emotion: json['emotion'] ?? '',
      timeStamp: parsedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
      'emotion': emotion,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}
