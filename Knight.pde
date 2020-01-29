class Knight extends Piece{
  public Knight(PieceColor clr){
    super(PieceType.KNIGHT, clr);
  }
  
  boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    int dRow = abs(toRow - fromRow);
    int dCol = abs(toCol - fromCol);
    int dist = dRow + dCol;
    return dist == 3 && dRow != 0 && dCol != 0;
  }
}
