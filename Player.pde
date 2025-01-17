class Player
{
  ArrayList<PVector> segments;
  PVector head;
  PVector direction;

  Player()
  {
    segments = new ArrayList<PVector>();
    head = new PVector(5, floor(ROWS / 2));
    direction = new PVector(1, 0);
    segments.add(head.copy());
  }

  void update()
  {
    segments.add(head.copy());
    head.add(direction);
  }

  void render()
  {
    noStroke();
    fill(0, 255, 0);
    for (PVector segment : segments)
    {
      square(segment.x * resolution, segment.y * resolution, resolution);
    }
  }

  void procInput()
  {
    switch(key)
    {
    case 'w':
      direction.set(0, -1);
      break;
    case 'a':
      direction.set(-1, 0);
      break;
    case 's':
      direction.set(0, 1);
      break;
    case 'd':
      direction.set(1, 0);
      break;
    }
    
    
  }
}
