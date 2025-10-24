import 'package:ai_app/domain/entities/message_entity.dart';

class ChatState {
  final List<MessageEntity> messages;
  final bool isLoading;
  final bool isTyping;
  final String? error;
  final bool suppressStream;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isTyping = false,
    this.error,
    this.suppressStream = false,
  });

  ChatState copyWith({
    List<MessageEntity>? messages,
    bool? isLoading,
    bool? isTyping,
    String? error,
    bool? suppressStream,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      error: error,
      suppressStream: suppressStream ?? this.suppressStream,
    );
  }
}
