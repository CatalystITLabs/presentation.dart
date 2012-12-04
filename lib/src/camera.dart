part of presentation;


///virtual camera to control the view of the scene
class Camera extends ThreeDimensionalObj {
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
    //..height = "${viewBox.clientHeight}"
    ..height = "100%"
    ..width = "100%"
    ..position = "relative"
    //preserve-3d will make objects in the scene maintain their positions and rotations relative to the scene and thus eachother
    ..transformStyle = "preserve-3d";
    this.move(0, 0, 0, 0, 0, 0, 0);
  }
  
  /// get the width of the viewBox
  int getXResolution()
  {
    return viewBox.clientWidth;
  }
  
  /// get the height of the viewBox
  int getYResolution()
  {
    return viewBox.clientHeight;
  }
  
  /// moves the scene to the center of the viewBox instead of the top left
  void centerFocalPoint()
  {
    this.scene.style
    ..marginLeft = "auto"
    ..marginRight = "auto"
    ..marginTop = "${getYResolution()~/2}px";
  }
  
   ///Reposition the virtual camera to a new place and rotation
  void move(num time, num x, num y, num z, num xr, num yr, num zr)
  {
    this.position
    ..x = x
    ..y = y
    ..z = z;
    this.rotation
    ..x = xr
    ..y = yr
    ..z = zr;
    // We simulate moving the camera by actually moving and rotating the scene.
    var sceneScale = 1.0;
    var translateScale = 1.0;
    var originScale = 1;
    var xOffset = this.scene.clientWidth ~/ 2;
    // vertical offset is only needed if the scene height differs from its container
    //var yOffset = this.scene.clientHeight ~/ 2;
    var yOffset = 0;
    
    scene.style   
    ..transition = "${time}s"
    // The center of rotation needs to be around the focal point of the camera.
    // Otherwise we would be looking at a different part of the scene after rotation.
    //..transformOrigin = "${(x * originScale).toInt()}px ${(z * originScale).toInt()}px ${(y * originScale).toInt()}px"
    ..transformOriginX = "${(x * originScale).toInt()}px"
    ..transformOriginY = "${(y * originScale).toInt()}px"
    ..transformOriginZ = "${(z * originScale).toInt()}px"

    //Rather than move the camera to the left we have to move the scene to the right etc.
    //Note that rotations have to be done in the reverse order to get back to (0,0,0)
    ..transform = "scale($sceneScale) translateX(${(-x+xOffset).toInt()}px) translateY(${(-y+yOffset).toInt()}px) translateZ(${(-z).toInt()}px) rotateZ(${-zr.toInt()}deg) rotateY(${-yr.toInt()}deg) rotateX(${-xr.toInt()}deg)";
  }
  
  ///Transition the camera to view a slide centered and normalized
  lookAtSlide(Slide slide, num time)
  {
    //center view on the center of the slide
    var xOffset = slide.element.clientWidth ~/ 2;
    var yOffset = slide.element.clientHeight ~/ 2;
    print ("centering slide... xOffset:$xOffset yOffset:$yOffset");
    move( time, slide.position.x + xOffset, slide.position.y + yOffset, slide.position.z, slide.rotation.x, slide.rotation.y, slide.rotation.z);
  }
}