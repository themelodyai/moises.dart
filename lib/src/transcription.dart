class LyricsTranscription {
  final List<LyricsTranscriptionSentence> sentences;

  const LyricsTranscription({required this.sentences});

  factory LyricsTranscription.fromJson(List<Map<String, dynamic>> json) {
    final sentences = json.map((sentence) {
      final words = sentence['words'] as List<Map<String, dynamic>>;
      return LyricsTranscriptionSentence(
        start: sentence['start'] as double,
        end: sentence['end'] as double,
        text: sentence['text'] as String,
        words: words.map((word) {
          return LyricsTranscriptionWord(
            word: word['word'] as String,
            start: word['start'] as double,
            end: word['end'] as double,
            score: word['score'] as double,
          );
        }),
        language: sentence['language'] as String,
      );
    }).toList();
    return LyricsTranscription(sentences: sentences);
  }
}

class LyricsTranscriptionSentence {
  final double start;
  final double end;
  final String text;
  final Iterable<LyricsTranscriptionWord> words;
  final String language;

  const LyricsTranscriptionSentence({
    required this.start,
    required this.end,
    required this.text,
    required this.words,
    required this.language,
  });
}

class LyricsTranscriptionWord {
  final String word;
  final double start;
  final double end;
  final double score;

  const LyricsTranscriptionWord({
    required this.word,
    required this.start,
    required this.end,
    required this.score,
  });
}
