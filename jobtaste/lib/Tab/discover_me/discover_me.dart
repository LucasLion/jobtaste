import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:envied/envied.dart';
part 'discover_me.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static String apiKey = _Env.apiKey;
}

class DiscoverMePage extends StatefulWidget {
  const DiscoverMePage({super.key});

  @override
  _DiscoverMePageState createState() => _DiscoverMePageState();
}

class _DiscoverMePageState extends State<DiscoverMePage> {
  final TextEditingController _controller = TextEditingController();
  Future<String>? _response;

  void _getResponse() {
    setState(() {
      _response = talk(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter your message',
            ),
            onSubmitted: (String value) {
              _getResponse();
            },
          ),
          ElevatedButton(
              onPressed: _getResponse,
              child: const Text('Envoyer'),
          ),
        apiResponse(),
        ],
      ),
    );
  }

  FutureBuilder<String> apiResponse() {
    return FutureBuilder<String>(
    future: _response,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Container(
          child: Center(
            child: Text(snapshot.data?? ""),
          ),
        );
      }
    }
  );
  }

  Future<String> talk(String input) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.baseUrl = 'https://api.openai.com';
    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "return any message you are given as JSON.",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    // the user message that will be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          input,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final whoAreYou = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "je souhaite spécialiser mon agent IA dans le domaine de l'éducation afin de le transformer en un conseiller d'orientation virtuel. Je fournirai des exemples de questions courantes posées par les étudiants, ainsi que des réponses pertinentes et des conseils d'orientation basés sur des données probantes. L'objectif est que l'agent IA puisse fournir des recommandations personnalisées sur les choix de carrière, les programmes d'études, les options universitaires, et aider les étudiants à prendre des décisions éclairées sur leur avenir académique et professionnel. Merci de personnaliser le modèle pour qu'il acquière une compréhension approfondie des parcours éducatifs et des besoins des étudiants.",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );
// all messages to be sent.
    final requestMessages = [
      systemMessage,
      userMessage,
      whoAreYou,
    ];

// the actual request.
    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-1106",
      responseFormat: {"type": "json_object"},
      seed: 6,
      messages: requestMessages,
      temperature: 0.2,
      maxTokens: 500,
    );
    String text = chatCompletion.choices[0].message.content.toString();
    print(chatCompletion.choices[0].message.content);
    return text;
  }
}