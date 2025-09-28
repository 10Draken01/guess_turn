class Player {
  final String name;
  int wins;
  
  Player({required this.name, this.wins = 0});
  
  void incrementWins() => wins++;
  void resetWins() => wins = 0;

  @override
  String toString() {
    return 'Player(name: $name, wins: $wins)';
  }
}