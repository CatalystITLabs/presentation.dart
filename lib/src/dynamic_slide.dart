part of presentation;

class DynamicSlide extends Slide{
  
  DynamicSlide(Element element, [num scale = 1, num x = 0, num y = 0, num z = 0, num heading = 0, num pitch = 0, num roll = 0]) : super(element, scale, x, y, z, heading, pitch, roll);
  
  ThreeDimensionalObj oldState = new ThreeDimensionalObj(0,0,0,0,0,0,0);
  
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
    oldState.copy(this);
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
    this.move(transitionDuration, oldState.position.x, oldState.position.y, oldState.position.z, oldState.rotation.x, oldState.rotation.y, oldState.rotation.z);
  }
}
