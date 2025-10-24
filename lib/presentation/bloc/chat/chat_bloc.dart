import 'package:ai_app/domain/entities/message_entity.dart';
import 'package:ai_app/domain/usecases/chat/erase_messages_usecase.dart';
import 'package:ai_app/domain/usecases/chat/get_api_response_usecase.dart';
import 'package:ai_app/domain/usecases/chat/get_messages_usecase.dart';
import 'package:ai_app/domain/usecases/chat/remove_message_usecase.dart';
import 'package:ai_app/domain/usecases/chat/send_message_usecase.dart';
import 'package:ai_app/presentation/bloc/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUsecase _getMessagesUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final GetApiResponseUsecase _getApiResponseUsecase;
  final EraseMessagesUsecase _eraseMessagesUsecase;
  final RemoveMessageUsecase _removeMessageUsecase;

  ChatBloc(
    this._getMessagesUsecase,
    this._sendMessageUsecase,
    this._getApiResponseUsecase,
    this._eraseMessagesUsecase,
    this._removeMessageUsecase,
  ) : super(ChatState().copyWith(isLoading: true)) {
    on<LoadMessagesRequested>(_onLoadMessages);
    on<SendMessageRequested>(_onSendMessage);
    on<EraseMessagesRequested>(_onEraseMessages);
    on<RemoveMessageRequested>(_onRemoveMessage);
  }
  Future<void> _onRemoveMessage(
    RemoveMessageRequested event,
    Emitter emit,
  ) async {
    try {
      await _removeMessageUsecase.call(
        uid: event.uid,
        messageId: event.messageId,
      );
      emit(state.copyWith(error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEraseMessages(
    EraseMessagesRequested event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(messages: [], suppressStream: true, error: null));
      await _eraseMessagesUsecase.call(uid: event.uid);
      emit(state.copyWith(suppressStream: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), suppressStream: false));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessagesRequested event,
    Emitter emit,
  ) async {
    try {
      await emit.forEach(
        _getMessagesUsecase.call(uid: event.uid),
        onData: (messages) {
          if (state.suppressStream) {
            return state.copyWith(messages: []);
          }
          return state.copyWith(
            messages: messages,
            isLoading: false,
            error: null,
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isTyping: false));
    }
  }

  Future<void> _onSendMessage(SendMessageRequested event, Emitter emit) async {
    try {
      final message = MessageEntity(
        text: event.text,
        sender: "user",
        timeStamp: DateTime.now(),
      );
      await _sendMessageUsecase.call(message: message, uid: event.uid);

      emit(state.copyWith(isTyping: true, error: null));

      final recentMessages = state.messages;

      final aiMessage = await _getApiResponseUsecase(
        currentUserMessage: event.text,
        recentMessages: recentMessages,
      );
      emit(state.copyWith(isTyping: false, error: null));
      await _sendMessageUsecase.call(uid: event.uid, message: aiMessage);
    } catch (e) {
      emit(state.copyWith(isTyping: false, error: e.toString()));
    }
  }
}
