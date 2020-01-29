class Bishop extends Piece{
  public Bishop(PieceColor clr){
    super(PieceType.BISHOP, clr);
  }
  
  boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    return checkDiagonals(fromRow, fromCol, toRow, toCol, MAX_DIST);
  }
}
