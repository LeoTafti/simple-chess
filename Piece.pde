//Only used to determine the image
enum PieceType {
  BISHOP, KING, KNIGHT, PAWN, QUEEN, ROOK
}

enum PieceColor {
  BLACK, WHITE
}

abstract class Piece{
  public Piece(PieceType type, PieceColor clr){
    this.img = getImg(type, clr);
    img.resize(CASE_WIDTH, CASE_HEIGHT);
    this.clr = clr;
  }
  
  //Only checks cases "in-between"
  public boolean checkDiagonals(int fromRow, int fromCol, int toRow, int toCol, int maxDist){
    if(abs(fromRow - toRow) != abs(fromCol - toCol)) //not diagonal
      return false;
    
    int dRow = fromRow < toRow ? 1 : -1;
    int dCol = fromCol < toCol ? 1 : -1;
    
    return checkDir(fromRow, fromCol, toRow, toCol, dRow, dCol, maxDist);
  }
  
  //Only checks cases "in-between"
  public boolean checkStraights(int fromRow, int fromCol, int toRow, int toCol, int maxDist){
    if(fromRow != toRow && fromCol != toCol)
      return false;
     
    int dRow = fromRow == toRow ? 0 : (fromRow < toRow ? 1 : -1);
    int dCol = fromCol == toCol ? 0 : (fromCol < toCol ? 1 : -1);
    
    return checkDir(fromRow, fromCol, toRow, toCol, dRow, dCol, maxDist);
  }
  
  //Only checks cases "in-between"
  private boolean checkDir(int fromRow, int fromCol, int toRow, int toCol, int dRow, int dCol, int maxDist){
    int row = fromRow + dRow;
    int col = fromCol + dCol;
    int dist = 1;
    
    //Check no piece in between
    while(!(row == toRow && col == toCol) && dist < maxDist){
      if(board.hasPiece(row, col))
        return false;
      
      row += dRow;
      col += dCol;
      dist++;
    }
    
    return true;
  }
  
  public abstract boolean canMoveTo(int fromRow, int fromCol, int toRow, int toCol);
  
  public void draw(){
    image(img, 0, 0);
  }
  
  public PieceColor getColor(){
    return this.clr;
  }
  
  private PImage getImg(PieceType type, PieceColor clr){
    String prefix;
    String suffix;
    
    if(clr == PieceColor.WHITE)
      prefix = "white_";
    else
      prefix = "black_";
      
    switch(type){
      case BISHOP:
        suffix = "bishop.png";
        break;
      case KING:
        suffix = "king.png";
        break;
      case KNIGHT:
        suffix = "knight.png";
        break;
      case PAWN:
        suffix = "pawn.png";
        break;
      case QUEEN:
        suffix = "queen.png";
        break;
      case ROOK:
        suffix = "rook.png";
        break;
      default:
        suffix = "";
    }
    
    return loadImage(prefix + suffix);
  }
  
  private PImage img;
  private PieceColor clr;
}
