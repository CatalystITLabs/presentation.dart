part of presentation;

///A 3 dimensional vector for css3 manipulations
class Vec3
{
  double x;
  double y;
  double z;
  
  ///construct from xyz components
  Vec3(this.x, this.y, this.z);
  
  ///returns the sum of two vectors
  Vec3 operator + (Vec3 other)
  {
    return new Vec3(x + other.x, y + other.y, z + other.z);
  }
  
  ///gets the length of the vector
  double get length
  {
    double sum = 0.0;
    sum += (x * x);
    sum += (y * y);
    sum += (z * z);
    return sqrt(sum);
  }
  
  double getRadians(double degrees)
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