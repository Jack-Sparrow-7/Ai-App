import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:ai_app/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository _repository;

  SendMessageUsecase({required ChatRepository repository}) : _repository = repository;

  Future<void> call({
    required String uid,
    required MessageEntity message,
  }) async {
    return _repository.sendMessage(uid: uid, message: message);
  }
}
