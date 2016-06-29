PImage img;
PImage lefty;
int leftyX = 0;
int leftyY = 0;
int leftyW = 0;
int leftyH = 0;
int clickCount = 0;
int newX, newY = 0;
int snakecount = 0;
PGraphics snakelayer;
int snakeBits = 50;
int[] exes = new int[snakeBits];
int[] whys = new int[snakeBits];
boolean wiggled = false;


void setup()
{
  img = loadImage("test.jpg");
  image(img, 0, 0);
  size(500, 500);
  snakelayer = createGraphics(width, height);
}

void draw()
{
  if (clickCount == 0 && mousePressed)
  {
    leftyX = mouseX;
    leftyY = mouseY;
    clickCount = 1;
    delay(100);
  }
   else if (clickCount == 1 && mousePressed)
  {
    leftyW = mouseX - leftyX;
    leftyH = mouseY - leftyY;
    clickCount = 5;
    lefty = get(leftyX, leftyY, leftyW, leftyH);
  }

  if (leftyH != 0)
  {
    if (wiggled == false)
    {
      firstWiggle();
    }
    else
    {
      snakeIt();
      snakecount++;
    }
  }
  
}

void snakeIt()
{
  image(img, 0, 0);
  snakelayer.beginDraw();
  snakelayer.clear();
  for (int i = 0; i < snakeBits; i++)
  {
    snakelayer.image(lefty, exes[i], whys[i]);
  }
  int randIndex = (int)random(1, snakeBits);
    float addAmount = (int)random((-5),5);
  print("~~" + addAmount + "~~");
  for (int a = 0; a < abs(addAmount); a++)
  {
    if (randIndex+a < snakeBits && randIndex-a > 0)
    {
      if (a==0)
      {
        whys[randIndex+a] += addAmount;
      }
      else
      {
        whys[randIndex-a] += addAmount+a;
        whys[randIndex+a] += addAmount+a;
      }
    }
  }
  snakelayer.endDraw();
  image(snakelayer, 0, 0);
}


void firstWiggle()
{
  int rand1 = (int)random(0, snakeBits/3);
  int rand2 = (int)random(rand1, snakeBits);
  int rand3 = (int)random(rand2, snakeBits);
  for (int i = 0; i < snakeBits; i++)
  {
    exes[i] = leftyX;
    whys[i] = leftyY;
    leftyX = leftyX + 2;
    if (i<rand1)
    {
      leftyY = leftyY + 4;
    }
    else if (i<rand2)
    {
      leftyY = leftyY-4;
    }
    else if (i<rand3)
    {
      leftyY = leftyY+4;
    }
    else
    {
      leftyY = leftyY - 4;
    }
  }
  wiggled = true;
}