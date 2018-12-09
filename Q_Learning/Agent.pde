class Agent
{
  PVector starting_pos, pos;
  int id;
  float offset = 0.5;
  color fill = color(255*random(1),255*random(1),155 + 100*random(1));
  int size = 20;
  
  float learning_rate = 0.6;
  float discount = 0.95;
  
  int prev_action;
  Tile prev_s1;
  ArrayList<Integer> actions = new ArrayList<Integer>();
  boolean additional_tweeks = true;
  
  float epsilon = 1;
  float decreasing_speed = 0.0001;
  float min_epsilon = 0.85;
  
  float[][][] Q_Values = new float[Q_Learning.MAP.length][Q_Learning.MAP[0].length][4];
  
  Agent(float pos_x, float pos_y)
  {
    starting_pos = new PVector(pos_x, pos_y);
    pos = new PVector(starting_pos.x, starting_pos.y);
    size *= SCALE;
  }
  
  void setID(int id)
  {
    this.id = id;
  }
  
  void draw()
  {
    if(AI_ON)
      choose_action(4);
    if (id == 0)
    {
      fill(0);
    textSize(20);
    text("Learning rate: " + learning_rate, 20, 35);
    text("Discount: " + discount, 300, 35);
    text("Epsilon: " + epsilon, 580, 35);
    }
    
    fill(fill);
    ellipse(TILE_SIZE * (pos.x + offset), TILE_SIZE * (pos.y + 1 + offset), size, size);
  }
  
  void choose_action(int choices)
  {
    Tile s1 = TILES[(int) pos.x][(int) pos.y];
    
    if(random(1) < epsilon)
    {
      int action = (int) random(4);
      if(additional_tweeks)
        {
          if(s1.Q_Values[action] < -0.5)
          action = (action + ceil(random(3)))%4;
          
          if(s1.Q_Values[action] != 0)
          {
            for(int i=0; i < 4; i++)
            {
              if(s1.Q_Values[i] == 0 && i != prev_action)
              {
                move(i);
                return;
              } 
            }
          }
        }
      move(action);
    }
    else
    {
      float best_value = max(TILES[(int) pos.x][(int) pos.y].Q_Values);
      for(int i = 0; i < choices; i++)
      {
        if(TILES[(int) pos.x][(int) pos.y].Q_Values[i] == best_value)
        {
          move(i);
          break;
        }
      }
    }
    epsilon -= decreasing_speed;
    if(epsilon < min_epsilon)
      epsilon = 0;
  }
  
  void move(int action)
  {
    Tile s1 = TILES[(int) pos.x][(int) pos.y];
    switch(action)
    {
      case 0:
      if(pos.y-1 >= 0)
            pos.y--;
      break;
      case 1:
      if(pos.x-1 >= 0)
              pos.x--;
      break;
      case 2:
      if(pos.y+1 < MAP[0].length)
            pos.y++;
      break;
      case 3:
      if(pos.x+1 < MAP.length)
                pos.x++;
      break;
    }
    if(additional_tweeks)
      actions.add(action);
    
    Tile s2 = TILES[(int) pos.x][(int) pos.y];
    evaluate(s1, action, s2);
    
    prev_action = action;
    prev_s1 = s1;
  }
  
  void move(char dir)
  {
    int action;
    Tile s1 = TILES[(int) pos.x][(int) pos.y];
    
    switch(dir)
    {
      case 'w':
        action = 0;
        if(pos.y-1 >= 0)
            pos.y--;
      break;
      case 's':
        action = 2;
        if(pos.y+1 < MAP[0].length)
            pos.y++;
      break;
      case 'a':
        action = 1;
        if(pos.x-1 >= 0)
              pos.x--;
      break;
      case 'd':
        action = 3;
        if(pos.x+1 < MAP.length)
                pos.x++;
      break;
      case 'r':
        restart();
      return;
      default:
      return;
    }
    
    Tile s2 = TILES[(int) pos.x][(int) pos.y];
    evaluate(s1, action, s2);
  }
  
  void evaluate(Tile s1, int action, Tile s2)
  {
    if(s2.score == -99)
    {
      pos = new PVector(s1.pos.x, s1.pos.y);
      s2 = s1;
    }
    
    s1.Q_Values[action] = ((1 - learning_rate) * s1.Q_Values[action] + learning_rate * discount * max(s2.Q_Values));
    
    if(s2.terminal)
    {
      for(int i = 0; i < s2.Q_Values.length; i++)
      {
        s2.Q_Values[i] = (1 - learning_rate) * s2.Q_Values[i] + learning_rate * s2.score;
      }
      
      if(BEST_REWARD < s2.Q_Values[0])
      {
        BEST_REWARD = s2.Q_Values[0];
      }
      else
      {
        actions.clear();
      }
      
      restart();
      
      if(additional_tweeks)
      {
        for(int i=0; i<actions.size(); i++)
        {
          move(actions.get(i));
        }
        actions.clear();
        return;
      }
    }
    else
    {
      s1.Q_Values[action] += learning_rate * discount * s2.score;
    }
    
    if(additional_tweeks)
    {
    if(s1 == s2)
      s1.Q_Values[action] -= 0.5;
      
    if(s2 == prev_s1)
      s1.Q_Values[action] -= 0.1;
    }
  }
  
  void restart()
  {
      pos.x = starting_pos.x;
      pos.y = starting_pos.y;
  }
}
