class Tile   //State
{
  PVector pos;
  float scale;
  int stroke = 1;
  int margin = 20;
  int size;
  color fill = 0xFFFFFFFF;
  color stroke_color = 0xFF000000;
  float score = 0;
  boolean terminal;
  
  float[] Q_Values = new float[4];
  float best = 1;
  float blue_coefficient;
  
  Tile(PVector pos, float scale)
  {
    this.pos = pos;
    this.scale = scale;
    margin *= scale;
    size = TILE_SIZE - margin;
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
      float height_diff = 12*(1-scale);
      textSize(12*scale);
      text(nf(Q_Values[0],1,2), text_pos.x +  22*scale, text_pos.y - height_diff);
      text(nf(Q_Values[1],1,2), text_pos.x, text_pos.y + 30*scale - height_diff);
      text(nf(Q_Values[2],1,2), text_pos.x + 22*scale, text_pos.y + 60*scale - height_diff);
      text(nf(Q_Values[3],1,2), text_pos.x + 45*scale, text_pos.y + 30*scale - height_diff);
    }
    else
    {
      if(score != -99)
      {
        fill(255 * (1-Q_Values[0]/BEST_REWARD), 255 * (1+Q_Values[0]/BEST_REWARD),255 * (1-abs(Q_Values[0])/blue_coefficient));
        rect(TILE_SIZE * pos.x + margin, TILE_SIZE * (pos.y + 1) + margin, size-margin, size-margin);
        fill(0);
        PVector text_pos = new PVector(TILE_SIZE * pos.x + margin/2 + 3*scale, TILE_SIZE * (pos.y + 1) + 3 * margin);
        if (abs(score) < 10)
          text_pos.x += 8 * scale;
        textSize(24*scale);
        text(nf(score,1,0), text_pos.x +  22*scale, text_pos.y);
      }
      else
      {
        fill(0);
        rect(TILE_SIZE * pos.x + margin, TILE_SIZE * (pos.y + 1) + margin, size-margin, size-margin);
      }
    }
  }
}
