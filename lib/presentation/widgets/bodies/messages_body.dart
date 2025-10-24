import 'package:ai_app/presentation/bloc/chat/chat_state.dart';
import 'package:ai_app/presentation/widgets/boxes/message_box.dart';
import 'package:ai_app/presentation/widgets/boxes/typing_box.dart';
import 'package:flutter/material.dart';

class MessagesBody extends StatefulWidget {
  const MessagesBody({super.key, required this.state});

  final ChatState state;

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MessagesBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.state.messages;

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: messages.length + (widget.state.isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < messages.length) {
            final message = messages[index];
            return MessageBox(message: message);
          } else {
            return const TypingBox();
          }
        },
      ),
    );
  }
}
