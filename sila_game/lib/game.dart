import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState(); // Game game = new Game();
}

class _GameState extends State<Game> {
  /// logic for sound starts

  Soundpool? _pool;
  SoundpoolOptions _soundPoolOptions = SoundpoolOptions();

  // TODO: check the functionality of this
  @override
  void initState() {
    super.initState();
    _initSoundPool(_soundPoolOptions);
  }

  @override
  Widget build(BuildContext context) {
    if (_pool == null) {
      return Material(
        child: Center(
          child: RaisedButton(
            onPressed: () => _initSoundPool(_soundPoolOptions),
            child: Text("Init Soundpool"),
          ),
        ),
      );
    } else {
      return SimpleApp(
        pool: _pool!,
        onOptionsChange: _initSoundPool,
      );
    }
  }

  void _initSoundPool(SoundpoolOptions soundPoolOptions) {
    print('* --- Initializing Sound Pool.');
    _pool?.dispose();

    setState(() {
      _soundPoolOptions = soundPoolOptions;
      _pool = Soundpool.fromOptions(options: _soundPoolOptions);
      print('* --- Sound Pool State Set: $_pool');
    });
  }

  /// logic for sound ends

}

class SimpleApp extends StatefulWidget {
  final Soundpool pool;
  final ValueSetter<SoundpoolOptions> onOptionsChange;
  SimpleApp({required this.pool, required this.onOptionsChange});

  @override
  _SimpleAppState createState() => _SimpleAppState();
}

class _SimpleAppState extends State<SimpleApp> {
  static const String TITLE = 'Sila Game';
  static const String IMAGE_PATH = 'assets/images/';
  static const List<String> CONSONANTS = ['b', 'c'];
  static const List<String> VOWELS = ['a', 'e', 'i', 'o', 'u'];

  int _vowelNumber = 0;
  int _consonantNumber = 0; // Random().nextInt(1);

  /// The idea for later is to do it randomly and in order
  void _updateSyllable() {
    setState(() {
      if (_vowelNumber < VOWELS.length - 1) {
        _vowelNumber++;
      } else {
        _vowelNumber = 0;
        // Random will be inserted later again.
        _consonantNumber = _consonantNumber == 0 ? 1 : 0;
      }
    });
  }

  late Future<List<int>> _consonantsSoundsIds;
  late Future<List<int>> _vowelsSoundsIds;
  Soundpool get _soundPool => widget.pool;

  void initState() {
    super.initState();
    _consonantsSoundsIds = _loadConsonantsSounds();
    _vowelsSoundsIds = _loadVowelsSounds();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: should I move these two later on?
    String syllable =
        CONSONANTS[_consonantNumber] + '  ' + VOWELS[_vowelNumber];
    String syllableImagePath = IMAGE_PATH +
        CONSONANTS[_consonantNumber] +
        VOWELS[_vowelNumber] +
        '.jpg';

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(TITLE))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(
                  cardType: "text",
                  cardFill: CONSONANTS[_consonantNumber].toUpperCase(),
                  cardFunction: _playConsonant,
                  cardSoundId: _consonantNumber,
                ),
                GameCard(
                  cardType: "text",
                  cardFill: VOWELS[_vowelNumber].toUpperCase(),
                  cardFunction: _playVowel,
                  cardSoundId: _vowelNumber,
                ),
              ],
            ),
            GameCard(
              cardType: "image",
              cardFill: syllableImagePath,
              cardFunction: _playImageSound,
              cardSoundId: 0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nueva Silaba',
        child: Icon(Icons.loop),
        onPressed: () {
          _updateSyllable();
        },
      ),
    );
  }

  Future<List<int>> _loadConsonantsSounds() async {
    List<int> consonantsSounds = [];
    const List<String> consonantsSoundsPaths = [
      "assets/sounds/beep_0.wav",
      "assets/sounds/beep_1.wav",
    ];

    for (int i = 0; i < consonantsSoundsPaths.length; i++) {
      var consonantAsset = await rootBundle.load(consonantsSoundsPaths[i]);
      var soundPoolWithConsonantSound = await _soundPool.load(consonantAsset);
      consonantsSounds.add(soundPoolWithConsonantSound);
    }

    return consonantsSounds;
  }

  Future<List<int>> _loadVowelsSounds() async {
    List<int> vowelsSounds = [];
    const List<String> vowelsSoundsPaths = [
      "assets/sounds/vowel_a.wav",
      "assets/sounds/vowel_e.wav",
      "assets/sounds/vowel_i.wav",
      "assets/sounds/vowel_o.wav",
      "assets/sounds/vowel_u.wav"
    ];

    for (int i = 0; i < vowelsSoundsPaths.length; i++) {
      var vowelAsset = await rootBundle.load(vowelsSoundsPaths[i]);
      var soundPoolWithVowelSound = await _soundPool.load(vowelAsset);
      vowelsSounds.add(soundPoolWithVowelSound);
    }

    return vowelsSounds;
  }

  Future<void> _playConsonant(int consonantNumber) async {
    var _consonantSound = await _consonantsSoundsIds;
    await _soundPool.play(_consonantSound[consonantNumber]);
  }

  Future<void> _playVowel(int vowelNumber) async {
    var _vowelSound = await _vowelsSoundsIds;
    await _soundPool.play(_vowelSound[vowelNumber]);
  }

  Future<void> _playImageSound(int nu) async {
    var imageAssetSound =
        await rootBundle.load("assets/sounds/water-droplet.mp3");
    var soundPoolWithImageSound = await _soundPool.load(imageAssetSound);
    // var _imageSound = await soundPoolWithImageSound;
    await _soundPool.play(soundPoolWithImageSound);
  }
}

class GameCard extends StatelessWidget {
  final String cardType;
  final String cardFill;
  final int cardSoundId;
  final Function cardFunction;

  GameCard({
    required this.cardType,
    required this.cardFill,
    required this.cardFunction,
    required this.cardSoundId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          cardFunction(cardSoundId);
        },
        child: SizedBox(
          width: this.cardType == "text" ? 100 : null,
          height: this.cardType == "text" ? 90 : null,
          child: Center(
            child: GameCardFill(cardType: cardType, cardFill: cardFill),
          ),
        ),
      ),
    );
  }
}

class GameCardFill extends StatelessWidget {
  final String cardFill;
  final String cardType;

  GameCardFill({required this.cardType, required this.cardFill});

  @override
  Widget build(BuildContext context) {
    return fillerWidget();
  }

  Widget fillerWidget() {
    if (cardType == "text") {
      return Text(
        cardFill,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80),
      );
    }

    return Image(
      image: AssetImage(cardFill),
      height: 250,
      semanticLabel: 'TODO: tell the name of the image displayed',
    );
  }
}
