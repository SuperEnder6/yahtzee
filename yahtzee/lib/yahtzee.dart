const NUMBER_OF_DICES = 5;
const CATEGORY_TEXT_SIZE = 20.0;
const ROW_HEIGHT = 30.0;
const NO_VALUE = -1;

List<int> values = [1, 1, 1, 1, 1];
int rollTime = 0;

List<bool> hold = [false, false, false, false, false];

List<int> singles = [
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE
];
int bonus = NO_VALUE;
int threeOfKind = NO_VALUE;
int fourOfKind = NO_VALUE;
int smStraight = NO_VALUE;
int laStraight = NO_VALUE;
int fullHouse = NO_VALUE;
int yahtzee = NO_VALUE;
int chance = NO_VALUE;

class Yahtzee {

  static int getScoreSingles(int n) {
    int tmp = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      if (values[i] == n) tmp += n;
    }
    return tmp;
  }

  static int getScoreTotal() {
    int tmp = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      tmp += values[i];
    }
    return tmp;
  }

  static int getScoreKind(int n) {
    List<int> tmpArr = [0,0,0,0,0,0];
    int ttl = getScoreTotal();
    for (int i = 0; i < 6; i++) {
      tmpArr[i] = countDicesForNumber(i+1);
    }
    for (int i = 0; i < 6; i++) {
      if(tmpArr[i] >= n) return ttl;
    }
    return 0;
  }

  static int getScoreStraight(int n) {
    List<int> tmpArr = [0,0,0,0,0,0];
    int cnt = 0;
    int maxCnt = 0;
    for(int i = 0; i < 6; i++){
      tmpArr[i] = countDicesForNumber(i+1);
    }
    for(int i = 0; i < 6; i++){
      if(tmpArr[i]>0) {
        cnt++;
      } else{
        maxCnt = maxCnt>cnt ? maxCnt : cnt;
        cnt = 0;
      }
    }
    maxCnt = maxCnt>cnt ? maxCnt : cnt;
    return ( maxCnt>=n ? (n*10-10) : 0);
  }

  static int getScoreFullHouse() {
    List<int> dices = [0, 0, 0, 0, 0];
    for (int i = 0; i < 5; i++) {
      dices[i] = values[i];
    }
    dices.sort();
    if (((dices[0] == dices[1] && dices[1] == dices[2]) &&
        (dices[3] == dices[4])) ||
        ((dices[0] == dices[1]) &&
            (dices[2] == dices[3] && dices[3] == dices[4]))) {
      return 25;
    }
    return 0;
  }

  static int getScoreYahtzee() {
    for (int i=1;i<NUMBER_OF_DICES;i++){
      if(values[i]!=values[i-1])return 0;
    }
    return 50;
  }

 static int countDicesForNumber(int number) {
    int count = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      if (values[i] == number) {
        count++;
      }
    }
    return count;
  }

  static int calculateSumOfSingles() {
    int sum = 0;
    for (int i = 0; i < 6; i++) {
      if (singles[i] >= 0) sum += singles[i];
    }
    return sum;
  }

  static int calculateBonus() {
    int sum = 0;
    for (int i = 0; i < 6; i++) {
      if (singles[i] >= 0) sum += singles[i];
    }
    return sum>=63?35:0;
  }

  static int calculateSumOfSinglesAndBonus() {
    return calculateSumOfSingles() + calculateBonus();
  }

  static int calculateSumOfSpecials() {
    int sum = 0;
    if (smStraight >= 0) sum += smStraight;
    if (laStraight >= 0) sum += laStraight;
    if (fullHouse >= 0) sum += fullHouse;
    if (threeOfKind >= 0) sum += threeOfKind;
    if (fourOfKind >= 0) sum += fourOfKind;
    if (yahtzee >= 0) sum += yahtzee;
    if (chance >= 0) sum += chance;
    return sum;
  }

  static int calculateSumOfSums() {
    return calculateSumOfSinglesAndBonus() + calculateSumOfSpecials();
  }
}