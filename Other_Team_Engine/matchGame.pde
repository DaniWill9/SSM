//Match Minigame UI
boolean showMatchGame = false;

//keypress for testing M (move to main later if necessary)
/*
void matchTest() {
  if (key == 'm' || key == 'M'){
  showMatchGame = true;
  }
}
*/

//list of cards
int[] matchCards = {0, 0, 1, 1, 2, 2};

//boolean revealed = 6;
//boolean matched = 6;

int matchedPairs = 0;

// match check
boolean checkPairs = false;

// just in case timer
int pairTimer = 0;

//need to swtich between each card
boolean[] revealed = new boolean[6];
boolean[] matched = new boolean[6];

//draw cards
void drawMatch() {
  // iterate for 6 cards check revealed or paired?
  for (int i = 0; i < 6; i++) {

    //or like 2d Ar[] (come back to this later)
    int x = 150 + (i * 3) * 120;
    int y = 150 +(i % 3) * 120;

    //if revealed read card
    if (revealed[i] || matched[i]) {
      //display
      text(matchCards[i], x, y);
    }
    else {
      //hidden card display
      text("?", x, y);
    }
  }
}