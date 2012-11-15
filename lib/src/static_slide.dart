part of presentation;

class StaticSlide extends Slide{
  StaticSlide(Element element, [num scale = 1, num x = 0, num y = 0, num z = 0, num heading = 0, num pitch = 0, num roll = 0]) : super(element, scale, x, y, z, heading, pitch, roll);
  
  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    super.onGainFocus(transitionDuration, slideShow);
    slideShow.cam.lookAtSlide(this, transitionDuration);
  }
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    super.onLoseFocus(transitionDuration, slideShow);
  }
}
