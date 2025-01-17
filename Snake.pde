long TICK_SPEED = 280;
long last_frame_time = 0;

boolean debug = false;

int COLS, ROWS;
int resolution;

Player player;

void setup()
{
  size(640, 360);

  resolution = 16;
  COLS = floor(width / resolution);
  ROWS = floor(height / resolution);

  player = new Player();
}

void draw()
{
  update();
  render();
}

void keyPressed()
{
  player.procInput();
  if (key == 'i') debug = !debug;
}

void update()
{
  long interval = (millis() - last_frame_time);
  if (interval < TICK_SPEED) return;
  player.update();
  last_frame_time = millis();

  if (!debug) return;
  println("Interval: " + interval);
  println("last frame time: " + last_frame_time);
}

void render()
{
  background(45);
  player.render();

  if (!debug) return;
  draw_grid();
}

void draw_grid()
{
  stroke(255, 45 /* 84% transparent */);
  for (int i = 0; i < COLS; i++) line(i * resolution, 0, i * resolution, height);   // Vertical lines
  for (int j = 0; j < ROWS; j++) line(0, j * resolution, width, j * resolution);    // Horizontal lines
}
