import 'package:flutter/material.dart';
import 'package:pet/api/postChatbot.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/style/colors.dart';
import 'package:pet/utils/format_date.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatbotScreen> {
  List<Map<String, dynamic>> _messages = [
    {
      'text' : "반려동물과 주인의 곁에 도움을 주는 코팻\n견습 수의사 ‘귄귄이’ 입니다.\n물어볼게 무엇인가요?\n\n‘코축이’는 AI챗봇 서비스로\n24시간 상담이 가능합니다.\n\n채팅이 끝나고 만일의 상황을 대비해 꼭\n가까운 병원에  직접 방문하여 수의사에게\n상담 받는 것을 권장드립니다!",
      'isUser' : false,
      'date' : formatDateToTime(DateTime.now())
    }
  ];

  TextEditingController _controller = TextEditingController();
  void _sendMessage(String message) {
    setState(() {
      _messages.add({
        'text': message,
        'isUser': true,
        'date' : formatDateToTime(DateTime.now())
      });
      _controller.clear();
    });

    Future.delayed(Duration(seconds: 1), (){
      setState(() {
        _messages.add({
          'text': '답변 중...',
          'isUser': false,
          'date' : formatDateToTime(DateTime.now())
        });
      });
    });

    Future.delayed(Duration(seconds: 2), () async{
      final answer = await postChatbot(message);
      setState(() {
        _messages.removeLast();
        _messages.add({
          'text': answer, // 백엔드로부터 받은 응답
          'isUser': false,
          'date' : formatDateToTime(DateTime.now())
        });
      });
    });
  }

  Widget CharacterWidget(){
    return Expanded(
        flex: 3,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'asset/img/chatbot/chatbot_character.png',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Text('견습 수의사', style: Theme.of(context).textTheme.titleSmall,),
            Text('귄귄이', style: Theme.of(context).textTheme.titleMedium,)
          ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: WHITE,
      appBar: GoBackAppBar(),
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'asset/img/chatbot/chatbot_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                keyboardHeight > 0 ?
                    SizedBox() : CharacterWidget(),
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                    reverse: true, // 최근 메시지가 아래에 위치하도록 반전
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];
                      return Align(
                        alignment: message['isUser']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child:Column(
                          crossAxisAlignment: message['isUser']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                          children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            margin: EdgeInsets.only(bottom: 5),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width*0.6
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                  offset:Offset(0,3),
                                  color: GREY2,
                                  blurRadius: 8
                              )],
                              color: message['isUser']
                                  ? PRIMARY_COLOR
                                  : WHITE,
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Text(
                              message['text'],
                              style: TextStyle(
                                  color: message['isUser'] ? Colors.white : Colors.black,
                                  fontFamily: 'NotoSansKR'
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(message['date'].toString(), style: Theme.of(context).textTheme.labelMedium,),
                          )
                        ],)
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: '질문을 입력해 주세요',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: GREY3),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: GREY3),
                                borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _sendMessage(_controller.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
