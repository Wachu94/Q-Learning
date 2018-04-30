class DrunkAgent extends Agent
{
  float self_control;
  
  DrunkAgent(float pos_x, float pos_y)
  {
    this(pos_x, pos_y, 0.1);
  }
  
  DrunkAgent(float pos_x, float pos_y, float self_control)
  {
    super(pos_x, pos_y);
    this.self_control = self_control;
    learning_rate = 0.5;
    min_epsilon = 0.85;
  }
  
  void move(char dir)
  {
    int action;
    Tile s1 = TILES[(int) pos.x][(int) pos.y];
    float sobriety_test = random(1f);
    
    switch(dir)
    {
      case 'w':
        action = 0;
      break;
      case 's':
        action = 2;
      break;
      case 'a':
        action = 1;
      break;
      case 'd':
        action = 3;
      break;
      case 'r':
        restart();
      return;
      default:
      return;
    }
    
    if(sobriety_test > self_control)
    {
      if(sobriety_test < self_control + (1-self_control)/2)
      {
        switch(dir)
        {
          case 'w':
            dir = 'a';
          break;
          case 's':
            dir = 'd';
          break;
          case 'a':
            dir = 's';
          break;
          case 'd':
            dir = 'w';
          break;
        }
      }
      else
      {
        switch(dir)
        {
          case 'w':
            dir = 'd';
          break;
          case 's':
            dir = 'a';
          break;
          case 'a':
            dir = 'w';
          break;
          case 'd':
            dir = 's';
          break;
        }
      }
    }
    
    switch(dir)
    {
      case 'w':
        if(pos.y-1 >= 0)
            pos.y--;
      break;
      case 's':
        if(pos.y+1 < MAP[0].length)
            pos.y++;
      break;
      case 'a':
        if(pos.x-1 >= 0)
            pos.x--;
      break;
      case 'd':
        if(pos.x+1 < MAP.length)
            pos.x++;
      break;
    }
    
    Tile s2 = TILES[(int) pos.x][(int) pos.y];
    evaluate(s1, action, s2);
  }
}
