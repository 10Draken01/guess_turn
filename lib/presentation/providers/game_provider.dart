import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:guess_turn/core/models/player.dart';

class GameProvider with ChangeNotifier {
  List<Player> _players = [];
  int _currentPlayerIndex = 0;
  int? _secretNumber;
  String? _lastGuessMessage;
  bool _isGameStarted = false;

  List<Player> get players => _players;
  int get currentPlayerIndex => _currentPlayerIndex;
  Player get currentPlayer => _players[_currentPlayerIndex];
  int? get secretNumber => _secretNumber;
  String? get lastGuessMessage => _lastGuessMessage;
  bool get isGameStarted => _isGameStarted;

  void setupPlayers(List<String> playerNames) {
    _players = playerNames.map((name) => Player(name: name)).toList();
    _currentPlayerIndex = 0;
    _generateSecretNumber();
    _isGameStarted = true;
    notifyListeners();
  }

  void _generateSecretNumber() {
    final random = Random();
    _secretNumber = random.nextInt(11); // 0 to 10 inclusive
  }

  void makeGuess(int guess) {
    if (!_isGameStarted || _secretNumber == null) return;

    final currentPlayerName = currentPlayer.name;

    if (guess == _secretNumber) {
      // Player wins!
      currentPlayer.incrementWins();
      _lastGuessMessage = '¡$currentPlayerName ha ganado! El número era $_secretNumber';
      _startNewRound();
    } else {
      // Wrong guess, next player's turn
      _lastGuessMessage = '$currentPlayerName adivinó $guess. ¡Incorrecto!';
      _nextPlayer();
    }
    notifyListeners();
  }

  void _nextPlayer() {
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
  }

  void _startNewRound() {
    _currentPlayerIndex = 0;
    _generateSecretNumber();
    
    // Clear the message after a delay for better UX
    Future.delayed(const Duration(seconds: 3), () {
      _lastGuessMessage = null;
      notifyListeners();
    });
  }

  void resetGame() {
    for (var player in _players) {
      player.resetWins();
    }
    _currentPlayerIndex = 0;
    _generateSecretNumber();
    _lastGuessMessage = null;
    notifyListeners();
  }

  void restartFromSetup() {
    _players.clear();
    _currentPlayerIndex = 0;
    _secretNumber = null;
    _lastGuessMessage = null;
    _isGameStarted = false;
    notifyListeners();
  }
}