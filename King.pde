class King extends Piece{
  public King(PieceColor clr, int row, int col){
    super(PieceType.KING, clr);
    setPos(row, col);
  }
  
  public boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    if(abs(fromRow - toRow) > 1 || abs(fromCol - toCol) > 1)
      return false;
    return (checkStraights(fromRow, fromCol, toRow, toCol, 1) || checkDiagonals(fromRow, fromCol, toRow, toCol, 1))
            && !inCheck(fromRow, fromCol, toRow, toCol);
    //TODO : Add check that we don't move to in-check position
  }
  
  private boolean inCheck(int fromRow, int fromCol, int toRow, int toCol){
    //Simulate moving the king to clicked position
    board.moveToEmpty(fromRow, fromCol, toRow, toCol);
    //Check if that would allow some piece to eat it
    for(int row = 0; row < CASES; row++){
       for(int col = 0; col < CASES; col++){
         if(board.hasPiece(row, col, board.getOppositeColor(this.getColor()))
             && board.getPiece(row, col).canMoveTo(row, col, toRow, toCol)){
             board.moveToEmpty(toRow, toCol, fromRow, fromCol);
             return true;
         }
       }
    }
    //Undo moving the king
    board.moveToEmpty(toRow, toCol, fromRow, fromCol);
    return false;
  }
  
  public void setPos(int row, int col){
    board.assertPos(row, col);
    
    this.row = row;
    this.col = col;
  }
  
  public int getRow(){
    return row;    
  }
  public int getCol(){
    return col;
  }
  
  private int row, col;
}
