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
  DiscoverMePageState createState() => DiscoverMePageState();
}

class DiscoverMePageState extends State<DiscoverMePage> {
  final TextEditingController _controller = TextEditingController();
  Future<String>? _response;
  final List<OpenAIChatCompletionChoiceMessageModel> _messageHistory = [];

  // Cette méthode initialise le contexte du conseiller d'orientation.
  void initializeContext() {
    final initMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "Bonjour, je suis votre conseiller d'orientation virtuel. Je suis ici pour répondre à vos questions sur les carrières et les études.",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );
    _messageHistory.add(initMessage);
  }

  @override
  void initState() {
    super.initState();
    initializeContext(); // Initialiser le contexte au démarrage de l'app.
  }

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
              child: Text(snapshot.data ?? ""),
            );
          }
        });
  }

  Future<String> talk(String input) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.baseUrl = 'https://api.openai.com';

    // Ajouter le message de l'utilisateur à l'historique.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(input),
      ],
      role: OpenAIChatMessageRole.user,
    );
    _messageHistory.add(userMessage);

    // Envoyer la requête avec l'historique des messages.
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: _messageHistory,
      temperature: 0.5,
      maxTokens: 250,
    );

    // Ajouter la réponse de l'API à l'historique.
    String responseText = chatCompletion.choices[0].message.content.toString();
    _messageHistory.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(responseText),
        ],
        role: OpenAIChatMessageRole.assistant,
      ),
    );

    return responseText;
  }
}
