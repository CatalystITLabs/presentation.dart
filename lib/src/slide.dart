part of presentation;

/// A slide of content for presentation.
class Slide extends ThreeDimensionalObj {
  Element element;
  bool inFocus = false;
  
  Slide(this.element, [num scale = 1, num x = 0, num y = 0, num z = 0, num heading = 0, num pitch = 0, num roll = 0]) : super(scale, x, y, z, heading, pitch, roll)
  {
    // use application specific styling for slides
    this.element.classes.add("slide");
    
    // don't leave required styling up to the external settings though
    this.element.style
    ..position = "absolute"
    ..transformStyle = "preserve-3d";
    
    //set initial positon and rotation
    this.setTransform();
  }
  
  /// Reposition the Slide to a new place and rotation within the scene
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
    this.element.style   
    ..transition = "${time}s";
    this.setTransform();
  }
  
  /// Reposition and reorient the slide within the scene to center it in front of the camera
  void moveToCamera(num time, Camera cam)
  {
    //move slide toward camera, compensating for height and width of the slide
    var x = cam.position.x - this.element.clientWidth / 2;
    var y = cam.position.y - this.element.clientHeight / 2;
    this.move(time, x, y, cam.position.z, cam.rotation.x, cam.rotation.y, cam.rotation.z);
  }

  setTransform()
  {
    //var xOffset = element.clientWidth ~/ 2;
    //var yOffset = element.clientHeight ~/ 2;
    //element.style.transform = "scale($scale) translateX(${(position.x-xOffset).toInt()}px) translateY(${(position.y-yOffset).toInt()}px) translateZ(${position.z.toInt()}px) rotateX(${rotation.x.toInt()}deg) rotateY(${rotation.y.toInt()}deg) rotateZ(${rotation.z.toInt()}deg)";
    // height and width report as 0 here for some reason
    element.style.transform = this.transformString;
  }

  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
      if (inFocus)
        return 0;
      element.style
      ..transition ="${transitionDuration}s ease-in-out";
      element.classes.add("focused");
      element.classes.remove("unfocused");
      inFocus = true;
  }
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
      if (!inFocus)
        return 0;
      element.style
      ..transition = "${transitionDuration}s ease-in-out";
      element.classes.add("unfocused");
      element.classes.remove("focused");
      inFocus = false;
  }
}