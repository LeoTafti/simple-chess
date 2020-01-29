class Pawn extends Piece{
  public Pawn(PieceColor clr){
    super(PieceType.PAWN, clr);
    hasntMoved = true;
  }
  
  boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol){
    int dRow = abs(toRow - fromRow);
    int dCol = abs(toCol - fromCol);
    boolean retval = false;
    if(dCol == 0){
      if(dRow == 1)
        retval = !board.hasPiece(toRow, toCol);
      else if(dRow == 2 && hasntMoved == true){
        if(!board.hasPiece(toRow, toCol) && !board.hasPiece((fromRow + toRow) / 2, toCol)){
          retval = true;
        }else{
          retval = false;
        }
      }
    }else if(dCol == 1 && dRow == 1)
      retval = board.hasPiece(toRow, toCol, board.getOppositeColor(this.getColor()));
    else retval = false;
    
    if(retval)
      hasntMoved = false;
    
    return retval;
  }
  
  private boolean hasntMoved;
}
