import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:envied/envied.dart';
part 'discover_me.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static String apiKey = _Env.apiKey;
}

class DiscoverMePage extends StatelessWidget {
  const DiscoverMePage({super.key});

  @override
  Widget build(BuildContext context) {
    init();
    return const Center(child: Text('Discover Me'));
  }

  void init() async {
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
          "Dessine moi un maximum d'emojis",
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

// all messages to be sent.
    final requestMessages = [
      systemMessage,
      userMessage,
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

    print(chatCompletion.choices.first.message); // ...
    print(chatCompletion.systemFingerprint); // ...
    print(chatCompletion.usage.promptTokens); // ...
    print(chatCompletion.id); // ...
  }
}
