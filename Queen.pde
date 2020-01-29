class Queen extends Piece{
  public Queen(PieceColor clr){
    super(PieceType.QUEEN, clr);
  }
  
  boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    return checkStraights(fromRow, fromCol, toRow, toCol, MAX_DIST) || checkDiagonals(fromRow, fromCol, toRow, toCol, MAX_DIST);
  }
}
