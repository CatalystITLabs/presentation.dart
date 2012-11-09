part of presentation;

class DynamicSlide extends Slide{
  
  DynamicSlide(Element element, num scale, num x, num y, num z, num h, num p, num r) : super(element, scale, x, y, z, h, p, r);
  
  ThreeDimensionalObj oldPosition = new ThreeDimensionalObj(0,0,0,0,0,0,0);
  
  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    //opacity
    super.onGainFocus(transitionDuration, slideShow);
    
    //mark old position
    oldPosition;
    oldPosition
    ..scale = this.scale
    // home position
    ..position = this.position
    // home rotation
    ..rotation = this.rotation;
    
    //move slide toward camera
    this.move(transitionDuration, slideShow.cam.position.x, slideShow.cam.position.y, slideShow.cam.position.z, slideShow.cam.rotation.x, slideShow.cam.rotation.y, slideShow.cam.rotation.z);
  }
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    //transparency
    super.onLoseFocus(transitionDuration, slideShow);
    
    //go home
    this.move(transitionDuration, oldPosition.position.x, oldPosition.position.y, oldPosition.position.z, oldPosition.rotation.x, oldPosition.rotation.y, oldPosition.rotation.z);
  }
}
