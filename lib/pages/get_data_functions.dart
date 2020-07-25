int totalPoints(teams,team) {
  int cnt=0;
  for (var player in teams[team].values) {
    cnt+= player.playerPoints;
  }
  return cnt;
}

int totalAssists(teams,team) {
  int cnt=0;
  for (var player in teams[team].values) {
    cnt+= player.playerAssists;
  }
  return cnt;
}

int totalRebounds(teams,team) {
  int cnt=0;
  for (var player in teams[team].values) {
    cnt+= player.playerRebounds;
  }
  return cnt;
}