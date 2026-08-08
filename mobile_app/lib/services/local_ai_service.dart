import 'dart:io';

import 'package:flutter/services.dart';
import 'package:llama_cpp/llama_cpp.dart';
import 'package:path_provider/path_provider.dart';

class LocalAIService {
  LlamaCpp? _llama;

  static const String _modelAsset =
      'assets/models/phi-3-mini-4k-instruct.gguf';

  /// Initialize the local GGUF model.
  Future<void> initModel() async {
    if (_llama != null) {
      return;
    }

    final modelPath = await _copyModelToDevice();

    _llama = await LlamaCpp.load(
      modelPath,
      nCtx: 2048,
    );
  }

  /// Copies the GGUF model from Flutter assets
  /// to a real file-system location.
  Future<String> _copyModelToDevice() async {
    final directory = await getApplicationSupportDirectory();

    final modelFile = File(
      '${directory.path}/phi-3-mini-4k-instruct.gguf',
    );

    if (await modelFile.exists()) {
      return modelFile.path;
    }

    final data = await rootBundle.load(_modelAsset);

    await modelFile.writeAsBytes(
      data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      ),
      flush: true,
    );

    return modelFile.path;
  }

  /// Analyze an invention using the local AI model.
  Future<String> analyzeInvention({
    required String title,
    required String description,
    required String category,
    required String inventor,
  }) async {
    if (_llama == null) {
      await initModel();
    }

    final prompt = '''
You are an AI invention analyst.

Analyze this invention:

Title: $title
Category: $category
Inventor: $inventor
Description: $description

Provide a professional analysis with these sections:

1. Strengths
2. Weaknesses
3. Market Potential
4. Improvement Suggestions

Give clear and practical recommendations.
''';

    final result = await _llama!.answer(prompt).join('');

    return result;
  }

  /// Release the native model resources.
  Future<void> dispose() async {
    await _llama?.dispose();
    _llama = null;
  }
}
