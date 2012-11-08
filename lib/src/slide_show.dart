part of presentation;

/**
 * a series of slides collected and maintains as a 3d scene.
 */
abstract class SlideShow
{
  List<Slide> slides = new List<Slide>();
  Camera cam;
  
  SlideShow(Element viewBox)
  {
    this.cam = new Camera(viewBox);
  }
  
  /**
   * Creates a new Slide object from a String of html
   */
  static Slide makeSlideFromHtml(String Html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slideElement = new DivElement();
    slideElement.innerHTML = Html;
    //slideElement.style.height = "1px";
    //slideElement.style.width = "1px";
    return makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
  }
  
  /**
   * Creates a new Slide object from a DOM element
   */
  static Slide makeSlideFromElement(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    return new Slide(slideElement, scale,x,y,z,h,p,r);
  }
  
  /**
   * Creates a new Slide object from a String of html and adds it to the end of the presentation
   */
  void addHtmlSlide(String Html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromHtml(Html, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slide.element);
    this.slides.add(slide);
  }
  
  /**
   * Creates a new Slide object from a DOM element and adds it to the end of the presentation
   */
  void addElementSlide(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slideElement);
    this.slides.add(slide);
  }
  
  /**
   * Focus on the input slide
   */
  void onFocus(Slide slide, [num transitionDuration = 0.7])
  { 
    for(var otherSlide in this.slides)
    {
      if (slide != otherSlide)
        otherSlide.onLoseFocus(transitionDuration);
    }
    slide.onGainFocus(transitionDuration);
  }
  
  /**
   * Advances the presentation to the next slide.
   */
  void next();
  
  /**
   * Returns the presentation to the previous slide.
   */
  void previous();
  
  /**
   * focus on the first slide
   */
  void start();
}