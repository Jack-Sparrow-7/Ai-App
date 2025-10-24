import 'package:ai_app/data/datasources/chat_datasource.dart';
import 'package:ai_app/data/models/message_model.dart';
import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:ai_app/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _chatDatasource;

  ChatRepositoryImpl({required ChatDatasource chatDatasource})
    : _chatDatasource = chatDatasource;

  @override
  Future<MessageEntity> getApiResponse({
    required List<MessageEntity> recentMessages,
    required String currentUserMessage,
  }) async {
    final recentMessagesList = recentMessages
        .map(
          (e) => MessageModel(
            messageId: e.messageId,
            text: e.text,
            sender: e.sender,
            emotion: e.emotion,
            timeStamp: e.timeStamp,
          ),
        )
        .toList();
    return await _chatDatasource.getApiResponse(
      recentMessages: recentMessagesList,
      currentUserMessage: currentUserMessage,
    );
  }

  @override
  Stream<List<MessageEntity>> getMessages({required String uid}) {
    return _chatDatasource
        .getMessages(uid: uid)
        .map(
          (models) => models
              .map(
                (model) => MessageEntity(
                  messageId: model.messageId,
                  text: model.text,
                  sender: model.sender,
                  timeStamp: model.timeStamp,
                  emotion: model.emotion,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> sendMessage({
    required String uid,
    required MessageEntity message,
  }) async {
    final messageModel = MessageModel(
      text: message.text,
      sender: message.sender,
      emotion: message.emotion,
      timeStamp: message.timeStamp,
    );
    return _chatDatasource.sendMessage(uid: uid, message: messageModel);
  }

  @override
  Future<void> eraseMessages({required String uid}) {
    return _chatDatasource.eraseMessages(uid: uid);
  }

  @override
  Future<void> removeMessage({required String uid, required String messageId}) {
    return _chatDatasource.removeMessage(uid: uid, messageId: messageId);
  }
}
