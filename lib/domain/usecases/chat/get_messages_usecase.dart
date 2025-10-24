import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:ai_app/domain/repositories/chat_repository.dart';

class GetMessagesUsecase {
  final ChatRepository _repository;

  GetMessagesUsecase({required ChatRepository repository}) : _repository = repository;

  Stream<List<MessageEntity>> call({required String uid}) {
    return _repository
        .getMessages(uid: uid);
  }
}
