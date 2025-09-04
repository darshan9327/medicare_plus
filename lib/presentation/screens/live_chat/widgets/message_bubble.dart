import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message['isUser'];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            const CircleAvatar(radius: 16, backgroundColor: Color(0xFF10B981), child: Icon(Icons.support_agent, color: Colors.white, size: 16)),
          if (!isUser) const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF2563EB) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft: isUser ? const Radius.circular(15) : const Radius.circular(5),
                  bottomRight: isUser ? const Radius.circular(5) : const Radius.circular(15),
                ),
                boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser && message.containsKey('senderName'))
                    Text(message['senderName'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2563EB))),
                  if (!isUser && message.containsKey('senderName')) const SizedBox(height: 4),
                  Text(message['message'], style: TextStyle(color: isUser ? Colors.white : const Color(0xFF111827))),
                  const SizedBox(height: 4),
                  Text(message['time'], style: TextStyle(fontSize: 12, color: isUser ? Colors.white70 : const Color(0xFF6B7280))),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 10),
          if (isUser)
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2563EB),
              child: Text("J", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
