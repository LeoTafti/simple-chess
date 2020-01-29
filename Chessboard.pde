class Chessboard{
  public Chessboard(){
    board = new Piece[CASES][CASES];
    selectedPiece = null;
    playerColor = PieceColor.WHITE;
  };
  
  private void addPiece(Piece piece, int row, int col){
    assertPos(row, col);
    assert(!hasPiece(row, col));
    
    board[row][col] = piece;
  }
  
  private void moveToEmpty(int fromRow, int fromCol, int toRow, int toCol){
     if(fromRow == toRow && fromCol == toCol)
       return;
     
     assert(!hasPiece(toRow, toCol));
     board[toRow][toCol] = board[fromRow][fromCol];
     board[fromRow][fromCol] = null;
  }
  
  //Asserts that hasSelected() == true and piece can legally be moved to (toRow, toCol)
  private void moveSelected(int toRow, int toCol){
    board[selRow][selCol] = null;
    board[toRow][toCol] = selectedPiece;
  }
  
  public void init(){
    for(int col = 0; col < CASES; col++){
      addPiece(new Pawn(PieceColor.BLACK), 1, col);
      addPiece(new Pawn(PieceColor.WHITE), 6, col);
    }
    initBaseRow(PieceColor.BLACK, 0);
    initBaseRow(PieceColor.WHITE, 7);
    
    blackKing = (King)getPiece(0, 4);
    whiteKing = (King)getPiece(7, 4);
  }
  
  private void initBaseRow(PieceColor clr, int row){
    addPiece(new Rook(clr), row, 0);
    addPiece(new Knight(clr), row, 1);
    addPiece(new Bishop(clr), row, 2);
    addPiece(new Queen(clr), row, 3);
    addPiece(new King(clr, row, 4), row, 4);
    addPiece(new Bishop(clr), row, 5);
    addPiece(new Knight(clr), row, 6);
    addPiece(new Rook(clr), row, 7);
  }
  
  //Draws the actual board. To be called once
  public void drawBoard(){
    for(int row = 0; row < CASES; row++){
      for(int col = 0; col < CASES; col++){
        
        if((row + col) % 2 == 0){
          stroke(255);
          fill(255);
        }else{
          stroke(160, 112, 0);
          fill(160, 112, 0);
        }
        
        rect(PADDING + col * CASE_HEIGHT, PADDING + row * CASE_WIDTH, CASE_WIDTH, CASE_HEIGHT);
      }
    }
    
    if(hasSelected()){
      strokeWeight(3);
      stroke(255, 155, 0);
      
      noFill();
      rect(PADDING + selCol * CASE_HEIGHT, PADDING + selRow * CASE_WIDTH, CASE_WIDTH, CASE_HEIGHT);
      
      strokeWeight(1);
      stroke(0);
    }
  }
  
  public void drawPieces(){
    for(int row = 0; row < CASES; row++){
      for(int col = 0; col < CASES; col++){
        if(hasPiece(row, col)){
          pushMatrix();
          translate(PADDING + col * CASE_WIDTH, PADDING + row * CASE_HEIGHT);
          getPiece(row, col).draw();
          popMatrix();
        }
      }
    }
  }
  
  public void clicked(int row, int col){
    if(hasSelected()){
      if(row == selRow && col == selCol)        //deselect
        selectedPiece = null;
      else if(hasPiece(row, col, playerColor)){ //select another piece
        selectedPiece = getPiece(row, col);
        selRow = row;
        selCol = col;
      }else if(selectedPiece.canMoveTo(selRow, selCol, row, col)){
        moveSelected(row, col);
        selectedPiece = null;
        switchPlayer();
      }else{
        //do nothing, illegal click 
      }
    }else{
      if(hasPiece(row, col, playerColor)){
        selectedPiece = getPiece(row, col);
        selRow = row;
        selCol = col;
      }
    }
  }
  
  private boolean hasPiece(int row, int col){
    assertPos(row, col);
    
    return board[row][col] != null;
  }
  
  private boolean hasPiece(int row, int col, PieceColor pColor){
    Piece p = getPiece(row, col);
    return p != null && p.getColor() == pColor;
  }
  
  private boolean hasEnemy(int row, int col){
    Piece p = getPiece(row, col);
    return p != null && p.getColor() != playerColor;
  }
  
  private Piece getPiece(int row, int col){
    assertPos(row, col);
    
    return board[row][col];
  }
  
  private boolean hasSelected(){
    return selectedPiece != null;
  }
  
  private void assertPos(int row, int col){
    assert(row >= 0 && row <= 7);
    assert(col >= 0 && col <= 7);
  }
  
  private void switchPlayer(){
    playerColor = getOppositeColor(playerColor);
  }
  
  private PieceColor getOppositeColor(PieceColor clr){
    if(clr == PieceColor.WHITE)
      return PieceColor.BLACK;
    return PieceColor.WHITE;
  }
  
  private Piece[][] board; //Less efficient than having one (or two) set(s) of pieces each with its position, but simpler
  private Piece selectedPiece;
  private King whiteKing;
  private King blackKing;
  private int selCol, selRow; //only valid when hasSelected() == true
  private PieceColor playerColor; //Color of current player
}
