import 'package:ai_app/domain/repositories/chat_repository.dart';

class EraseMessagesUsecase {
  final ChatRepository _repository;

  EraseMessagesUsecase({required ChatRepository repository})
    : _repository = repository;

  Future<void> call({required String uid
  }) async {
    return _repository.eraseMessages(uid: uid);
  }
}
