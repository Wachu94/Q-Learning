Agent agent;
ArrayList<Agent> agents = new ArrayList<Agent>();

static boolean AI_ON = true;

static float BEST_REWARD = 0.8;

static final int TILE_SIZE = 100;
static final int WIDTH = 1000;
static final int HEIGHT = 800;

static float[][] MAP = new float[WIDTH/TILE_SIZE][HEIGHT/TILE_SIZE - 1];
static Tile[][] TILES = new Tile[WIDTH/TILE_SIZE][HEIGHT/TILE_SIZE - 1];

int f_rate = 60;
boolean different_blue;

void setup()
{
  frameRate(f_rate);
  size(1000,800);
  useMap(1,3);
}

void draw()
{
  background(0xFFFFFFFF);
  
  for(int i = 0; i < TILES.length; i++)
  {
    for(int j = 0; j < TILES[0].length; j++)
    {
    TILES[i][j].draw();
    }
  }
  for (Agent agent : agents)
    agent.draw();
}

void keyPressed()
{
  if(key == 'w' || key == 's' || key == 'a' || key == 'd')
    agents.get(0).move(key);
  if(key == 'q')
    f_rate /= 2;
  if(key == 'e')
    f_rate *= 2;
  if(key == 'v')
    different_blue = !different_blue;
  frameRate(f_rate);
}

void useMap(int nr, int nr_of_agents)
{
  switch(nr)
  {
    case 0:
      MAP[9][6] = 100;
      MAP[9][0] = 25;
      MAP[6][3] = 10;
      MAP[2][1] = 3;
      MAP[1][0] = 5;
      
      MAP[3][5] = -10;
      MAP[0][4] = -100;
      
      MAP[7][5] = -99;
      MAP[8][5] = -99;
      MAP[9][5] = -99;
    break;
    case 1:
      MAP[4][0] = 1;
      MAP[6][0] = 5;
      MAP[9][6] = 10;
      MAP[7][0] = 50;
      
      MAP[1][1] = -99;
      MAP[1][2] = -99;
      MAP[1][3] = -99;
      MAP[1][4] = -99;
      MAP[1][5] = -99;
      MAP[1][6] = -99;
      
      MAP[3][0] = -99;
      MAP[3][1] = -99;
      MAP[3][2] = -99;
      MAP[3][3] = -99;
      MAP[3][4] = -99;
      MAP[3][5] = -99;
      
      MAP[7][5] = -99;
      MAP[8][5] = -99;
      MAP[9][5] = -99;
      
      MAP[5][6] = -99;
      MAP[5][5] = -99;
      MAP[5][4] = -99;
      
      MAP[5][2] = -99;
      MAP[5][1] = -99;
      MAP[5][0] = -99;
      
      MAP[7][1] = -99;
      MAP[7][2] = -10;
      MAP[7][3] = -99;
      
      MAP[8][1] = -99;
      MAP[8][2] = -10;
      MAP[8][3] = -99;
    break;
  }
  
  for(int i = 0; i < MAP.length; i++)
  {
    for(int j = 0; j < MAP[0].length; j++)
    {
      Tile tile = new Tile(new PVector(i,j));
      tile.score = MAP[i][j];
      TILES[i][j] = tile;
    }
  }
  
  switch(nr)
  {
    case 0:
      TILES[9][6].terminal = true;
      TILES[9][0].terminal = true;
      TILES[6][3].terminal = true;
      TILES[2][1].terminal = true;
      TILES[1][0].terminal = true;
      
      TILES[3][5].terminal = true;
      TILES[0][4].terminal = true;
      
      TILES[7][5].terminal = true;
      TILES[8][5].terminal = true;
      TILES[9][5].terminal = true;
      
      agents.add(new Agent(0,0));
      agents.add(new Agent(4,5));
      agents.add(new Agent(3,2));
      agents.add(new Agent(9,3));
      agents.add(new Agent(7,1));
    break;
    case 1:
      TILES[4][0].terminal = true;
      TILES[6][0].terminal = true;
      TILES[7][0].terminal = true;
      TILES[9][6].terminal = true;
      
      TILES[1][1].terminal = true;
      TILES[1][2].terminal = true;
      TILES[1][3].terminal = true;
      TILES[1][4].terminal = true;
      TILES[1][5].terminal = true;
      TILES[1][6].terminal = true;
      
      TILES[3][0].terminal = true;
      TILES[3][1].terminal = true;
      TILES[3][2].terminal = true;
      TILES[3][3].terminal = true;
      TILES[3][4].terminal = true;
      TILES[3][5].terminal = true;
      
      TILES[7][5].terminal = true;
      TILES[8][5].terminal = true;
      TILES[9][5].terminal = true;
      
      TILES[5][6].terminal = true;
      TILES[5][5].terminal = true;
      TILES[5][4].terminal = true;
      
      TILES[5][2].terminal = true;
      TILES[5][1].terminal = true;
      TILES[5][0].terminal = true;
      
      TILES[7][1].terminal = true;
      TILES[7][3].terminal = true;
      
      TILES[8][1].terminal = true;
      TILES[8][3].terminal = true;
      
      for(int i = 0; i<nr_of_agents; i++)
        agents.add(new Agent(0,6));
    break;
  }
}
