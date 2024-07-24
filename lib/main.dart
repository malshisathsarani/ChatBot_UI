import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController _controller = TextEditingController();

  List<Message> messages = [
    Message(
      text: "Hi Jane!",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSendByMe: false,
    ),
    Message(
      text: "How can I assist you?",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSendByMe: false,
    ),
    Message(
      text: "What is depression",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSendByMe: true,
    ),
    Message(
      text: "  .... ",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSendByMe: false,
    ),
    // Additional messages...
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0), // Adjust the height as needed
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
            child: AppBar(
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/Group.svg',
                  semanticsLabel: 'Acme Logo',

                ),
                onPressed: () {},
              ),
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.blue, size: 40,),
                  onPressed: () {},
                ),
              ],
              title: const Text(
                'JOY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Background image
            Container(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.blue.withOpacity(0.3),
                    )
                  ],
                )
            ),
            Column(
              children: [

                SizedBox(height: 380,),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: message.isSendByMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!message.isSendByMe)
                              SvgPicture.asset(
                                'assets/Group.svg',
                                semanticsLabel: 'Acme Logo',
                                width: 50,
                                height: 50,
                              ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: message.isSendByMe ? Colors.blue : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  message.text,
                                  style: TextStyle(
                                    color: message.isSendByMe ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (message.isSendByMe)
                             Image(image: AssetImage('assets/user.png'))
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.file_copy_outlined, color: Colors.blue),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Ask something...',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (text) {
                            final message = Message(
                              text: text,
                              date: DateTime.now(),
                              isSendByMe: true,
                            );
                            setState(() {
                              messages.add(message);
                            });
                            _controller.clear();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.mic_outlined, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
  });
}
