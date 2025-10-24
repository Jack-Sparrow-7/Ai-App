import 'package:ai_app/domain/entities/message_entity.dart';

abstract interface class ChatRepository {
  Stream<List<MessageEntity>> getMessages({required String uid});

  Future<void> sendMessage({
    required String uid,
    required MessageEntity message,
  });

  Future<MessageEntity> getApiResponse({
    required List<MessageEntity> recentMessages,
    required String currentUserMessage,
  });

  Future<void> eraseMessages({required String uid});

  Future<void> removeMessage({
    required String uid,
    required String messageId,
  });
}
