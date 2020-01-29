public final int CASES = 8;
public final int MAX_DIST = CASES;
public final int WIDTH = 500, HEIGHT = 500;
public final int PADDING = 50;
public final int BOARD_WIDTH = WIDTH - PADDING*2, BOARD_HEIGHT = HEIGHT - PADDING*2;
public final int CASE_WIDTH = BOARD_WIDTH / CASES, CASE_HEIGHT = BOARD_HEIGHT / CASES;
public final int MIN_X = PADDING, MIN_Y = PADDING;
public final int MAX_X = PADDING + CASES * CASE_WIDTH, MAX_Y = PADDING + CASES * CASE_HEIGHT;

Chessboard board;

void setup(){
  size(500, 500);
  board = new Chessboard();
  board.init();
}

void draw(){
  background(150);
  board.drawBoard();
  board.drawPieces();
}

void mouseClicked(){
  if(mouseX > MIN_X && mouseX < MAX_X
      && mouseY > MIN_Y && mouseY < MAX_Y){
      int col = floor(map(mouseX, MIN_X, MAX_X, 0, CASES));
      int row = floor(map(mouseY, MIN_Y, MAX_Y, 0, CASES));
      board.clicked(row, col);
  }
}
