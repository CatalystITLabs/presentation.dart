part of presentation;


///virtual camera to control the view of the scene
class Camera extends Object {
  /// The render acts as a window into the 3d scene and controls the perspective of the virtual "camera"
  Element viewBox;
  /// The scene is used to collect items in 3d space to render and goes inside the viewBox in the DOM
  Element scene = new DivElement();
  
  Camera(this.viewBox) : super(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  {
    //build and style the scene element
    viewBox.insertAdjacentElement("beforeEnd", scene);
    this.centerFocalPoint();
    scene.style
    ..height = "1px"
    ..width = "1px"
    ..position = "relative"
    //preserve-3d will make objects in the scene maintain their positions and rotations relative to the scene and thus eachother
    ..transformStyle = "preserve-3d";
  }
  
  /**
   * get the width of the viewBox
   */
  int getXResolution()
  {
    return viewBox.clientWidth;
  }
  
  /**
   * get the height of the viewBox
   */
  int getYResolution()
  {
    return viewBox.clientHeight;
  }
  
  /**
   * moves the scene to the center of the viewBox instead of the top left
   */
  void centerFocalPoint()
  {
    this.scene.style
    ..marginLeft = "auto"
    ..marginRight = "auto"
    ..marginTop = "${getYResolution()~/2}px";
  }
  
  /**
   * Reposition the virtual camera to a new place and rotation
   */
  void move(num time, num x, num y, num z, num xr, num yr, num zr)
  {
    //We simulate moving the camera by actually moving and rotating the scene.
      
    var sceneScale = 1.0;
    var translateScale = 1.0;
    var originScale = 1;
    
    scene.style   
    ..transition = "${time}s"
    //The center of rotation needs to be around the focal point of the camera.
    // Otherwise we would be looking at a different part of the scene after rotation.
    //..transformOrigin = "${(x * originScale).toInt()}px ${(z * originScale).toInt()}px ${(y * originScale).toInt()}px"
    ..transformOriginX = "${(x * originScale).toInt()}px"
    ..transformOriginY = "${(y * originScale).toInt()}px"
    ..transformOriginZ = "${(z * originScale).toInt()}px"

    //Rather than move the camera to the left we have to move the scene to the right etc.
    //Note that rotations have to be done in the reverse order to get back to (0,0,0)
    ..transform = "scale($sceneScale) translateX(${(-x).toInt()}px) translateY(${(-y*translateScale).toInt()}px) translateZ(${(-z*translateScale).toInt()}px) rotateZ(${-zr.toInt()}deg) rotateY(${-yr.toInt()}deg) rotateX(${-xr.toInt()}deg)";
  }
}