
class BasicSlideShow extends SlideShow
{
  
  BasicSlideShow(Element viewBox): super(viewBox);
  
  int currentSlideIndex = 0;
  /**
   * Moves the virtual camera over the current slide.
   * You can optionally specify how long it takes to transition to this slide.
   */
  void focusCurrentSlide([num transitionDuration = 0.7])
  { 
    var slide = this.slides[currentSlideIndex];
    this.highlightSlide(slide, transitionDuration);
    
    //focus on the center of the slide
    var xOffset = slide.element.clientWidth ~/ 2;
    var yOffset = slide.element.clientHeight ~/ 2;
    //var xOffset = 0;
    //var yOffset = 0;
    this.cam.move( transitionDuration, slide.position.x + xOffset, slide.position.y + yOffset, slide.position.z, slide.rotation.x, slide.rotation.y, slide.rotation.z);
  }
  
  /**
   * Advances the presentation to the next slide.
   */
  void next()
  {
    if (slides.length < 1)
      return;
    currentSlideIndex++;
    if (currentSlideIndex >= slides.length)
      currentSlideIndex = 0;
    focusCurrentSlide(0.7);
  }
  
  /**
   * Returns the presentation to the previous slide.
   */
  void previous()
  {
    if (slides.length < 1)
      return;
    currentSlideIndex--;
    if (currentSlideIndex < 0)
      currentSlideIndex = slides.length - 1;
    focusCurrentSlide(0.3);
  }
  
  /**
   * focus on the first slide
   */
  void start()
  {
    if (slides.length < 1)
      return;
    currentSlideIndex = 0;
    focusCurrentSlide(0.0);
  }
}
