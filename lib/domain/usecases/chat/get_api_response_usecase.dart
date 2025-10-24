import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:ai_app/domain/repositories/chat_repository.dart';

class GetApiResponseUsecase {
  final ChatRepository _repository;

  GetApiResponseUsecase({required ChatRepository repository})
    : _repository = repository;

  Future<MessageEntity> call({
    required List<MessageEntity> recentMessages,
    required String currentUserMessage,
  }) async {
    return _repository.getApiResponse(
      recentMessages: recentMessages,
      currentUserMessage: currentUserMessage,
    );
  }
}
