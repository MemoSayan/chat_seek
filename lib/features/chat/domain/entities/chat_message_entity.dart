
class ChatMessage {
  final String content;
  final String role;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.role,
    required this.timestamp,
  });

  toUiModel() {}

 
}
