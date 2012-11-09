part of presentation;


///Any item with 3d position and rotation
class ThreeDimensionalObj {
  num scale;
  // home position
  Vec3 position;
  // home rotation
  Vec3 rotation;
  // heading (y axis rotation)
  // pitch (x axis rotation)
  // roll (z axis rotation)
  
  ThreeDimensionalObj(this.scale, num x, num y, num z, num heading, num pitch, num roll)
  {
    position = new Vec3(x,y,z);
    rotation = new Vec3(pitch, heading, roll);
  }
  
  //copy(ThreeDimensionalObj other);
  
  String get transformString
  {
    return "scale($scale) translateX(${position.x.toInt()}px) translateY(${position.y.toInt()}px) translateZ(${position.z.toInt()}px) rotateX(${rotation.x.toInt()}deg) rotateY(${rotation.y.toInt()}deg) rotateZ(${rotation.z.toInt()}deg)";
  }
}
