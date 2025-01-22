boolean debug = false;

int COLS, ROWS;
int RESOLUTION;

PVector head;
ArrayList<PVector> snake;
PVector[] directions;
PVector direction;       

PVector food;

int high_score;

void setup() {
  size(640, 360);
  frameRate(6);

  RESOLUTION = 20;
  COLS = width / RESOLUTION;
  ROWS = height / RESOLUTION;

  directions = new PVector[4];
  directions[0] = new PVector(1, 0); // Right
  directions[1] = new PVector(-1, 0); // Left
  directions[2] = new PVector(0, 1);  // Up
  directions[3] = new PVector(0, -1); // Down
  direction = directions[0];
 
  head = new PVector(5, floor(ROWS / 2));
  snake = new ArrayList<PVector>();
  snake.add(head.copy());
  move_snake();
  move_snake();
  move_snake();

  food = new PVector(floor(COLS / 2), floor(ROWS / 2));
}

void draw() {

  update_snake();
  update_score();

  background(45);
  render_food();
  render_snake();

  if (!debug) return;
  render_grid();
}

void keyPressed() {
  direction = key == 'w' && direction != directions[2] ? direction = directions[3] : direction;
  direction = key == 'a' && direction != directions[0] ? direction = directions[1] : direction;
  direction = key == 's' && direction != directions[3] ? direction = directions[2] : direction;
  direction = key == 'd' && direction != directions[1] ? direction = directions[0] : direction; 
  
  if (key == 'i') debug = !debug;
}

void update_snake() {
  move_snake();
  
  // This is where the wrapping broke
  
  if (food.equals(head)) {
    while (snake.contains(food)){
      food.set(floor(random(COLS)), floor(random(ROWS)));
    }
    return;
  }  

  int last_segment = snake.size() - 1;
  snake.remove(last_segment);
}

void move_snake() {
  head.add(direction);

  // @Collision(snake)
  if (snake.contains(head)) println("Dead");

  // @Wrapping 
  if (head.x > COLS) head.x = 0;
  if (head.x < 0) head.x = COLS;
  if (head.y > ROWS) head.y = 0;
  if (head.y < 0) head.y = ROWS;
  
  snake.add(0, head.copy());
}

void update_score() {
  int score = snake.size();
  if (score > high_score) high_score = score;
  surface.setTitle("Score: " + score + "        HI-Score: " + high_score);
}

void render_snake() {
  // noStroke();
  // fill(0, 255, 0);
  // for (PVector segment : snake) {
    // square(segment.x * RESOLUTION, segment.y * RESOLUTION, RESOLUTION);
  // }
 
  noFill(); 
  stroke(0, 255, 0);
  strokeWeight(RESOLUTION - 2);
  strokeCap(SQUARE);
 
  float offset = RESOLUTION / 2;
  beginShape();
  for (PVector segment : snake) {
    float x = (segment.x * RESOLUTION) - offset;
    float y = (segment.y * RESOLUTION) - offset;
    vertex(x, y);
  } 
  endShape();
}

void render_food() {
  noStroke();
  fill(255, 0, 0);
  square(food.x * RESOLUTION, food.y * RESOLUTION, RESOLUTION);
}

void render_grid() {
  stroke(255, 30);
  for (int i = 0; i < COLS; ++i) line(i * RESOLUTION, 0, i * RESOLUTION, height);
  for (int j = 0; j < ROWS; ++j) line(0, j * RESOLUTION, width, j * RESOLUTION);
}
