import 'package:ai_app/domain/repositories/chat_repository.dart';

class RemoveMessageUsecase {
  final ChatRepository _repository;

  RemoveMessageUsecase({required ChatRepository repository})
    : _repository = repository;

  Future<void> call({required String uid, required String messageId}) {
    return _repository.removeMessage(uid: uid, messageId: messageId);
  }
}
