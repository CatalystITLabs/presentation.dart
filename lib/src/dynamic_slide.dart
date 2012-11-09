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
    //ignore if we're already in focus
    if (inFocus)
      return 0;
    
    //opacity
    super.onGainFocus(transitionDuration, slideShow);
    
    //mark old position and rotation before moving to camera
    oldPosition.copy(this);
    this.moveToCamera(transitionDuration, slideShow.cam);
  }
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    //ignore if we're already out of focus
    if (!inFocus)
      return 0;
    
    //transparency
    super.onLoseFocus(transitionDuration, slideShow);
    
    //go home
    this.move(transitionDuration, oldPosition.position.x, oldPosition.position.y, oldPosition.position.z, oldPosition.rotation.x, oldPosition.rotation.y, oldPosition.rotation.z);
  }
}
