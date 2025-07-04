class LyricsTranscription {
  final List<LyricsTranscriptionSentence> sentences;

  const LyricsTranscription({required this.sentences});

  const LyricsTranscription.empty() : sentences = const [];

  factory LyricsTranscription.fromJson(List<Map<String, dynamic>> json) {
    final sentences = json.map((sentence) {
      final words = (sentence['words'] as List).cast<Map>();
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
        singers: sentence['singer'] != null
            ? () {
                final singers = sentence['singer'] as String;
                return singers.isNotEmpty
                    ? singers.split(',').map((s) => s.trim()).toList()
                    : const <String>[];
              }()
            : const <String>[],
      );
    }).toList();
    return LyricsTranscription(sentences: sentences);
  }

  @override
  String toString() => sentences.map((e) => e.text).join('\n');
}

class LyricsTranscriptionSentence {
  final double start;
  final double end;
  final String text;
  final Iterable<LyricsTranscriptionWord> words;
  final String language;
  final List<String> singers;

  const LyricsTranscriptionSentence({
    required this.start,
    required this.end,
    required this.text,
    required this.words,
    required this.language,
    required this.singers,
  });

  @override
  String toString() {
    return 'LyricsTranscriptionSentence(start: $start, end: $end, text: $text, words: $words, language: $language)';
  }
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

  @override
  String toString() {
    return 'LyricsTranscriptionWord(word: $word, start: $start, end: $end, score: $score)';
  }
}
