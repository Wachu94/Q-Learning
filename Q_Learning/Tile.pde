class Tile   //State
{
  PVector pos;
  int stroke = 1;
  int margin = 20;
  int size = TILE_SIZE - margin;
  color fill = 0xFFFFFFFF;
  color stroke_color = 0xFF000000;
  float score = 0;
  boolean terminal;
  
  float[] Q_Values = new float[4];
  float best = 1;
  float blue_coefficient;
  
  Tile(PVector pos)
  {
    this.pos = pos;
  }
  
  void draw()
  {
    fill(fill);
    stroke(stroke_color);
    strokeWeight(stroke);
    rect(TILE_SIZE * pos.x + margin/2, TILE_SIZE * (pos.y + 1) + margin/2, size, size);
    
    if(different_blue)
      blue_coefficient = BEST_REWARD;
    else
      blue_coefficient = 1;
    
    if(!terminal)
    {
      fill(255 * (1-Q_Values[0]/BEST_REWARD), 255 * (1+Q_Values[0]/BEST_REWARD),255 * (1-abs(Q_Values[0])/blue_coefficient));
      triangle(TILE_SIZE * pos.x + margin/2, TILE_SIZE * (pos.y + 1) + margin/2, 
               TILE_SIZE * pos.x + margin/2 + size/2, TILE_SIZE * (pos.y + 1) + margin/2 +size/2, 
               TILE_SIZE * pos.x + margin/2 + size, TILE_SIZE * (pos.y + 1) + margin/2);
               
      fill(255 * (1-Q_Values[1]/BEST_REWARD), 255 * (1+Q_Values[1]/BEST_REWARD), 255 * (1-abs(Q_Values[1])/blue_coefficient));      
      triangle(TILE_SIZE * pos.x + margin/2, TILE_SIZE * (pos.y + 1) + margin/2, 
               TILE_SIZE * pos.x + margin/2 + size/2, TILE_SIZE * (pos.y + 1) + margin/2 +size/2, 
               TILE_SIZE * pos.x + margin/2, TILE_SIZE * (pos.y + 1) + margin/2 + size);
               
      fill(255 * (1-Q_Values[2]/BEST_REWARD), 255 * (1+Q_Values[2]/BEST_REWARD), 255 * (1-abs(Q_Values[2])/blue_coefficient));          
      triangle(TILE_SIZE * pos.x + margin/2 + size, TILE_SIZE * (pos.y + 1) + margin/2 + size, 
               TILE_SIZE * pos.x + margin/2 + size/2, TILE_SIZE * (pos.y + 1) + margin/2 +size/2, 
               TILE_SIZE * pos.x + margin/2, TILE_SIZE * (pos.y + 1) + margin/2 + size);
               
      fill(255 * (1-Q_Values[3]/BEST_REWARD), 255 * (1+Q_Values[3]/BEST_REWARD), 255 * (1-abs(Q_Values[3])/blue_coefficient));         
      triangle(TILE_SIZE * pos.x + margin/2 + size, TILE_SIZE * (pos.y + 1) + margin/2 + size, 
               TILE_SIZE * pos.x + margin/2 + size/2, TILE_SIZE * (pos.y + 1) + margin/2 +size/2, 
               TILE_SIZE * pos.x + margin/2 + size, TILE_SIZE * (pos.y + 1) + margin/2);
               
      fill(0,0,0);
      PVector text_pos = new PVector(TILE_SIZE * pos.x + margin/2 + 5, TILE_SIZE * (pos.y + 1) + margin/2 + 15);
      textSize(12);
      text(nf(Q_Values[0],1,2), text_pos.x + 22, text_pos.y);
      text(nf(Q_Values[1],1,2), text_pos.x, text_pos.y + 30);
      text(nf(Q_Values[2],1,2), text_pos.x + 22, text_pos.y + 60);
      text(nf(Q_Values[3],1,2), text_pos.x + 45, text_pos.y + 30);
    }
    else
    {
      if(score != -99)
        fill(255 * (1-Q_Values[0]/BEST_REWARD), 255 * (1+Q_Values[0]/BEST_REWARD),255 * (1-abs(Q_Values[0])/blue_coefficient));
      else
        fill(0);
      rect(TILE_SIZE * pos.x + margin, TILE_SIZE * (pos.y + 1) + margin, size-margin, size-margin);
    }
  }
}
