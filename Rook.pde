class Rook extends Piece{
  public Rook(PieceColor clr){
    super(PieceType.ROOK, clr);
  }
  
  boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    return checkStraights(fromRow, fromCol, toRow, toCol, MAX_DIST);
  }
}
