part of presentation;

class StaticSlide extends Slide{
  StaticSlide(Element element, num scale, num x, num y, num z, num h, num p, num r) : super(element, scale, x, y, z, h, p, r);
  
  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
    super.onGainFocus(transitionDuration, slideShow);
    slideShow.cam.focusOnSlide(this, transitionDuration);
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
