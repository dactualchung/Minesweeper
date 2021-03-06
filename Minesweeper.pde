

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
         buttons[r][c] = new MSButton(r, c);
      }
    }
    
    for(int i = 0; i < 50; i++){
      setBombs();
    }
}
public void setBombs()
{
  int rRow = (int)(Math.random() * NUM_ROWS);
  int rCol = (int)(Math.random() * NUM_COLS);
  if(!bombs.contains(buttons[rRow][rCol])){
    bombs.add(buttons[rRow][rCol]);
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
  for (int i = 0; i < NUM_ROWS; i++){
    for (int j = 0; j < NUM_COLS; j++) {
      if (!bombs.contains(buttons[i][j]) && buttons[i][j].isClicked() == false){
        return false;
      }
    }
  } 
  return true;
}
public void displayLosingMessage()
{
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("O");
  buttons[10][8].setLabel("U");
  buttons[10][9].setLabel(" ");
  buttons[10][10].setLabel("L");
  buttons[10][11].setLabel("O");
  buttons[10][12].setLabel("S");
  buttons[10][13].setLabel("E");
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++) {
      if(bombs.contains(buttons[i][j]) && (buttons[i][j].isClicked() == false)){
         buttons[i][j].mousePressed();
      }
    }
  }
}
public void displayWinningMessage()
{
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("O");
  buttons[10][8].setLabel("U");
  buttons[10][9].setLabel(" ");
  buttons[10][10].setLabel("W");
  buttons[10][11].setLabel("I");
  buttons[10][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
          marked = !marked;
          if(!marked){
            clicked = false;
          }
        }else if(bombs.contains(this)){
          displayLosingMessage();
        }else if(countBombs(r, c) > 0){
           label = "" + countBombs(r, c);
        }else{
          for(int rol = r - 1; rol <= r + 1; rol++){
            for(int col = c - 1; col <= c + 1; col++){
              if(isValid(rol, col) && !buttons[rol][col].isClicked()){
                buttons[rol][col].mousePressed();
              }
            }
          }
        }
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
          return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int r = row - 1; r <= row + 1; r++){
          for(int c = col - 1; c<= col + 1; c++){
            if(isValid(r, c) && bombs.contains(buttons[r][c])){
               numBombs++;
            }
          }
        }
        if(bombs.contains(buttons[row][col])){
          numBombs--;
        }
        return numBombs;
    }
}
