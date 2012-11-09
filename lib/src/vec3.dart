part of presentation;

///A 3 dimensional vector for css3 manipulations
class Vec3
{
  num x;
  num y;
  num z;
  
  ///construct from xyz components
  Vec3(this.x, this.y, this.z);
  
  ///returns the sum of two vectors
  Vec3 copy (Vec3 other)
  {
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }
  
  ///gets the length of the vector
  num get length
  {
    num sum = 0.0;
    sum += (x * x);
    sum += (y * y);
    sum += (z * z);
    return sqrt(sum);
  }
  
  num getRadians(num degrees)
  {
    return degrees * PI / 180;
  }
  
  ///convert angles of rotation in degrees around 3 axis to a vector of length 1
  Vec3 angleToVector()
  {
    return new Vec3(cos(y)*cos(x),
        sin(y),
        cos(y)*sin(x));
  }
}