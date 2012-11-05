part of presentation;

/**
 * virtual camera to control the view of the scene
 */
class Camera extends Object {
  Element viewBox;
  Element scene;
  
  Camera(this.viewBox, this.scene) : super(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  {
    this.centerFocalPoint();
  }
  
  int getXResolution()
  {
    return viewBox.clientWidth;
  }
  
  int getYResolution()
  {
    return viewBox.clientHeight;
  }
  
  /**
   * moves the scene to the center of the viewbox instead of the top left
   */
  void centerFocalPoint()
  {
    this.scene.style
    ..marginLeft = "${getXResolution()~/2}px"
    ..marginTop = "${getYResolution()~/2}px";
  }
  
  /**
   * Reposition the virtual camera to a new place and rotation
   */
  void move(double x, double y, double z, double xr, double yr, double zr)
  {
    //We simulate moving the camera by actually moving and rotating the scene.
    
    var sceneScale = 1.0;
    var translateScale = 1.0;
    var originScale = 1;
    
    scene.style
    ..transition = "0.6s"
    
    //The center of rotation needs to be around the focal point of the camera.
    // Otherwise we would be looking at a different part of the scene after rotation.
    //..transformOrigin = "${(x * originScale).toInt()}px ${(z * originScale).toInt()}px ${(y * originScale).toInt()}px"
    ..transformOriginX = "${(x * originScale).toInt()}px"
    //..transformOriginX = "900px"
    ..transformOriginY = "${(y * originScale).toInt()}px"
    //..transformOriginY = "900px" //test 
    ..transformOriginZ = "${(z * originScale).toInt()}px"
    //..transformOriginZ = "900px" //test 


    //Rather than move the camera to the left we have to move the scene to the right etc.
    ..transform = "scale($sceneScale) translateX(${(-x*translateScale).toInt()}px) translateY(${(-y*translateScale).toInt()}px) translateZ(${(-z*translateScale).toInt()}px) rotateZ(${-zr.toInt()}deg) rotateY(${-yr.toInt()}deg) rotateX(${-xr.toInt()}deg)";
  }
}