import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the window manager
  await windowManager.ensureInitialized();

  // Set the initial window size
  await windowManager.setSize(Size(1280, 720));

  // Restrict resizing to prevent going below 1280x720
  await windowManager.setMinimumSize(Size(1280, 720));

  windowManager.setAspectRatio(16 / 9);

  runApp(Match2Game());
}

class Match2Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group 4\'s Matching Stars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playHomePageMusic();
    
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Difficulty"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(difficulty: "easy"),
                      ),
                    );
                  },
                  child: Text("Easy"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(difficulty: "medium"),
                      ),
                    );
                  },
                  child: Text("Medium"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(difficulty: "hard"),
                      ),
                    );
                  },
                  child: Text("Hard"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Play homepage background music
  void _playHomePageMusic() async {
    await _audioPlayer.setSource(AssetSource('sounds/homepage_bg_music.mp3')); // Load the homepage background music
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the background music
    await _audioPlayer.setVolume(0.4); // Set the volume
    _audioPlayer.play(AssetSource('sounds/homepage_bg_music.mp3')); // Play the music
  }

  // Stop homepage background music
  void _stopHomePageMusic() async {
    await _audioPlayer.stop(); // Stop the music
  }

  @override
  void dispose() {
    _stopHomePageMusic(); // Ensure music stops when leaving the HomePage
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matching Stars", // Title of the AppBar
          style: TextStyle(
            fontFamily: 'Stepalange', // Replace with your desired font family
            fontSize: 24,
            color: const Color.fromARGB(255, 255, 255, 255), // You can change the color too
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9, // Locking the aspect ratio to 16:9
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homepage_bg.png'), // Replace with your background image path
                fit: BoxFit.cover,// Ensures the image covers the whole screen
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Group 4's",
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Stepalange',
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  "Matching Stars",
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'Stepalange',
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "A card-matching game",
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Stepalange',
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 40),
                Image.asset(
                  'assets/images/Sun_Logo.png', // Replace with your logo path
                  width: 150, // Fixed logo size
                  height: 150, // Fixed logo size
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/Twinkle.png', // Replace with your side image path
                      width: 60, // Fixed side image size
                      height: 60, // Fixed side image size
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _stopHomePageMusic(); // Stop music when navigating to the game page
                        _showDifficultyDialog(context); // Show difficulty dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[200], // Light yellow background color
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Increase button size
                        textStyle: TextStyle(
                          fontSize: 20, // Make text larger
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Start Game"),
                    ),
                    Image.asset(
                      'assets/images/Twinkle.png', // Replace with your side image path
                      width: 60, // Fixed side image size
                      height: 60, // Fixed side image size
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add leaderboard navigation if necessary
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[200], // Light yellow background color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Increase button size
                    textStyle: TextStyle(
                      fontSize: 20, // Make text larger
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text("Leaderboards"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RotationYTransition extends StatelessWidget {
  final Animation<double> turns;
  final Widget front;
  final Widget back;

  const RotationYTransition({
    required this.turns,
    required this.front,
    required this.back,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: turns,
      builder: (context, child) {
        final angle = turns.value * pi;
        final isUnder = (angle > pi / 2);
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        return Transform(
          alignment: Alignment.center,
          transform: transform,
          child: isUnder ? back : front,
        );
      },
    );
  }
}


class CardModel {
  final String imagePath;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.imagePath,
    this.isFlipped = false,
    this.isMatched = false,
  });
}

class GamePage extends StatefulWidget {
  final String difficulty;

  GamePage({required this.difficulty});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  AudioPlayer _audioPlayer = AudioPlayer();
  List<CardModel> cards = [];
  bool wait = false;
  int score = 0;
  int combo = 1;
  late Timer _timer;
  late int remainingTime;
  late int columns;
  late int rows;

  late AnimationController _backgroundController;
  late final Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.difficulty == "easy") {
      remainingTime = 180; // 3 minutes
    } else if (widget.difficulty == "medium") {
      remainingTime = 300; // 5 minutes
    } else if (widget.difficulty == "hard") {
      remainingTime = 420; // 7 minutes
    }
    _playBackgroundMusic();
    cards = _generateShuffledCards();
    _startTimer();

    _backgroundController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat(); // This loops the animation

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_backgroundController);
}

  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('sounds/bg_music.mp3')); // Load the background music
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the background music
    _audioPlayer.setVolume(0.25);
    _audioPlayer.play(AssetSource('sounds/bg_music.mp3')); // Play the music
  }


  List<CardModel> _generateShuffledCards() {
    List<String> imageNames;
    
    if (widget.difficulty == "easy") {
    imageNames = [
      'Asteroid',
      'Astronaut',
      'Aurora',
      'Black_Hole',
      'Comet',
      'Constellation',
      'Earth',
      'Eclipse',
      'Jetpack',
      'Jupiter',
      'Mars',
      'Mercury',
    ];
  } else if (widget.difficulty == "medium") {
    imageNames = [
      'Asteroid',
      'Astronaut',
      'Aurora',
      'Black_Hole',
      'Comet',
      'Constellation',
      'Earth',
      'Eclipse',
      'Jetpack',
      'Jupiter',
      'Mars',
      'Mercury',
      'Meteor_Shower',
      'Meteor',
      'Milky_Way',
      'Moon',
      'Neptune',
      'Pluto',
      'Rocket',
      'Satellite',
    ];
  } else {
    imageNames = [
      'Asteroid',
      'Astronaut',
      'Aurora',
      'Black_Hole',
      'Comet',
      'Constellation',
      'Earth',
      'Eclipse',
      'Jetpack',
      'Jupiter',
      'Mars',
      'Mercury',
      'Meteor_Shower',
      'Meteor',
      'Milky_Way',
      'Moon',
      'Neptune',
      'Pluto',
      'Rocket',
      'Satellite',
      'Saturn',
      'Stars',
      'Sun',
      'Super_Giant',
      'Supernova',
      'Telescope',
      'UFO',
      'Uranus',
      'Venus',
      'Wormhole',
    ];
  }

    List<String> cardPaths = imageNames.map((name) => 'assets/images/$name.png').toList();

    List<CardModel> cardList = cardPaths
        .expand((path) => [
              CardModel(imagePath: path),
              CardModel(imagePath: path),
            ])
        .toList();

    cardList.shuffle(Random());
    return cardList;
  }

  Widget _buildSlidingBackground() {
  return AnimatedBuilder(
    animation: _backgroundAnimation,
    builder: (context, child) {
      // Use MediaQuery to get screen width
      final screenWidth = MediaQuery.of(context).size.width;
      final offset = -_backgroundAnimation.value * screenWidth;

      return Stack(
        children: [
          Positioned(
            left: offset,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Main_BG.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: offset + screenWidth,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Main_BG.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildGameContent() {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Set columns and rows dynamically based on the difficulty
      int columns = widget.difficulty == "easy" ? 6 : widget.difficulty == "medium" ? 10 : 15;
      int rows = 4;  // Keep rows fixed to 4, as in easy mode
      double spacing = 8;
      double infoHeight = 200;

      double availableWidth = constraints.maxWidth - (spacing * (columns - 1));
      double availableHeight = constraints.maxHeight - infoHeight - (spacing * (rows - 1));

      // Keep the height of each card fixed based on rows
      double cardHeight = availableHeight / rows;
      double maxCardWidth = availableWidth / columns;

      double cardAspectRatio = 5 / 7;
      double cardWidth = maxCardWidth; // Horizontal size of cards

      // If the card width is too wide, adjust it to maintain aspect ratio
      double cardHeightAdjusted = cardWidth / cardAspectRatio;

      // If the card height exceeds the available height, adjust the width accordingly
      if (cardHeightAdjusted > cardHeight) {
        cardHeightAdjusted = cardHeight;
        cardWidth = cardHeightAdjusted * cardAspectRatio;
      }

      return Column(
        children: [
          SizedBox(height: 20),
          Text("Time: ${remainingTime}s", style: TextStyle(
            fontFamily: 'Stepalange',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
          Text("Score: $score", style: TextStyle(
            fontFamily: 'Stepalange',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: SizedBox(
                width: (cardWidth * columns) + (spacing * (columns - 1)),
                height: (cardHeight * rows) + (spacing * (rows - 1)),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,  // Dynamically set based on difficulty
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: cardAspectRatio,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return _buildCard(index);
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime--;
      });

      if (remainingTime == 0) {
        _timer.cancel();
        _showGameOver();
      }
    });
  }

  void _onCardTap(int index) async {
  if (wait || cards[index].isFlipped || cards[index].isMatched) return;

  // Use a separate instance for each flip sound
  final flipPlayer = AudioPlayer();
  await flipPlayer.play(AssetSource('sounds/card_flip.mp3'));
  flipPlayer.onPlayerComplete.listen((event) {
    flipPlayer.dispose();
  });

  setState(() {
    cards[index].isFlipped = true;
  });

  final flippedCards = cards.where((card) => card.isFlipped && !card.isMatched).toList();

  if (flippedCards.length == 2) {
  wait = true;

  Future.delayed(Duration(seconds: 1), () async {
    setState(() {
      if (flippedCards[0].imagePath == flippedCards[1].imagePath) {
        flippedCards[0].isMatched = true;
        flippedCards[1].isMatched = true;
        score += 10 * combo;
        combo++;
      } else {
        flippedCards[0].isFlipped = false;
        flippedCards[1].isFlipped = false;
        combo = 1;
      }
      wait = false;
      _checkForWin();
    });

    if (flippedCards[0].imagePath == flippedCards[1].imagePath) {
      final matchPlayer = AudioPlayer();
      await matchPlayer.play(AssetSource('sounds/match.mp3'));
      matchPlayer.onPlayerComplete.listen((event) {
        matchPlayer.dispose();
      });
    } else {
      final errorPlayer = AudioPlayer();
      await errorPlayer.play(AssetSource('sounds/mismatch.mp3'));
      errorPlayer.onPlayerComplete.listen((event) {
        errorPlayer.dispose();
      });
    }
  });
}
}
void _checkForWin() {
  bool allMatched = cards.every((card) => card.isMatched);
  
  if (allMatched) {
    _showWinDialog();
  }
}

void _showWinDialog() {
  int totalScore = score * remainingTime; // Calculate total score
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You Win!'),
        content: Text('Your Final Score: $totalScore\nTime Left: $remainingTime seconds'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Navigate back to the home page
            },
            child: Text('Back to Home'),
          ),
        ],
      );
    },
  );
}

  void _showGameOver() {
    int finalScore = score * remainingTime;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your Final Score: $finalScore'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard(int index) {
  final card = cards[index];
  final showFront = card.isFlipped || card.isMatched;

  return GestureDetector(
    onTap: () => _onCardTap(index),
    child: TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: showFront ? 1.0 : 0.0),
      duration: Duration(milliseconds: 300),
      builder: (context, value, child) {
        final isUnder = value > 0.5;
        final angle = value * pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: isUnder
          ? KeyedSubtree(key: ValueKey('front-$index'), child: _buildCardFace(card.imagePath))
          : KeyedSubtree(key: ValueKey('back-$index'), child: _buildCardFace('assets/images/Back_Card_Design.png')),

        );
      },
    ),
  );
}

Widget _buildCardFace(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text(
          "Matching Stars",
          style: TextStyle(
            fontFamily: 'Stepalange',
            fontSize: 24,
            color: const Color.fromARGB(255, 255, 255, 255), 
          ),
        ),
    backgroundColor: Colors.blueGrey,
  ),
  body: Stack(
    children: [
      _buildSlidingBackground(), // <- your background
      _buildGameContent(),       // <- your original game UI
    ],
  ),
);
}

  @override
  void dispose() {
    _timer.cancel();
    _backgroundController.dispose();
    _audioPlayer.stop();
    super.dispose();
  }
}