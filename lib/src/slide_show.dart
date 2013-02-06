part of presentation;

SlideShow _lastCreatedSlideShow;

/**
 * Returns the last SlideShow instantiated.
 * It is not a true singleton because it will not instantiate
 * for you or limit instantiation to one object.
 */
getSlideShow()
{
  return _lastCreatedSlideShow;
}

/**
 * a series of slides collected and maintains as a 3d scene.
 */
abstract class SlideShow
{
  /// actual slides in the slide show 
  List<Slide> slides = new List<Slide>();
  
  /**
   * background slides that aren't just for scenery
   * or aren't part of the normal slide progression and logic
   * slides in background shouldn't be affected by transitions
   */
  List<Slide> background = new List<Slide>();
  
  /// this virtual camera controls the position and orientation of the viewer relative to the 3d scene 
  Camera cam;
  
  Slide get currentSlide;
  
  SlideShow(Element viewBox)
  {
    this.cam = new Camera(viewBox);
    _lastCreatedSlideShow = this;
  }
  
  /**
   * Creates a new Slide object from a String of html
   */
  Slide makeSlideFromHtml(String html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slideElement = new DivElement();
    slideElement.innerHtml = html;
    return makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
  }
  
  bool useDynamic = false;
  /**
   * Creates a new Slide object from a DOM element
   */
  Slide makeSlideFromElement(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    //useDynamic = !useDynamic;
    if (useDynamic)
      return new DynamicSlide(slideElement, scale,x,y,z,h,p,r);
    else
      return new StaticSlide(slideElement, scale,x,y,z,h,p,r); 
  }
  
  /**
   * Creates a new Slide object from a String of html and adds it to the end of the presentation
   */
  Slide addHtmlSlide(String html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromHtml(html, scale, x, y, z, h, p, r);
    addSlide(slide);
    return slide;
  }
  
  /**
   * Creates a new Slide object from a DOM element and adds it to the end of the presentation
   */
  Slide addElementSlide(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
    addSlide(slide);
    return slide;
  }
  
  /**
   * Add a slide to the presentation and its scene
   */
  Slide addSlide(Slide slide)
  {
    // start out of focus
    slide.inFocus = true;
    slide.onLoseFocus(0);
    
    // add to scene and slides list
    this.cam.scene.insertAdjacentElement("beforeEnd", slide.element);
    this.slides.add(slide);
    
    return slide;
  }
  
  /**
   * Create new slide from HTML and add to scene in separate background list
   */
  Slide addBackgroundHtmlSlide(String html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slideElement = new DivElement();
    slideElement.innerHtml = html;
    return addBackgroundElementSlide(slideElement, scale, x, y, z, h, p, r);
  }
  
  /**
   * Create new slide from a DOM element and add to scene in separate background list
   */
  Slide addBackgroundElementSlide(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = new Slide(slideElement, scale,x,y,z,h,p,r); 
    addBackgroundSlide(slide);
    return slide;
  }
  
  /**
   * Add a slide to scene as a background
   */
  Slide addBackgroundSlide(Slide slide)
  {
    //TODO: less hackish styling for slides vs background
    slide.element.classes.remove("slide");
    slide.element.classes.add("backgroundSlide");
    
    //add to scene and background list
    this.cam.scene.insertAdjacentElement("beforeEnd", slide.element);
    this.background.add(slide);
    return slide;
  }
  
  /**
   * Focus on the input slide
   */
  void onFocus(Slide slide, [num transitionDuration = 0.7])
  { 
    for(var otherSlide in this.slides)
    {
      if (slide != otherSlide)
        otherSlide.onLoseFocus(transitionDuration, this);
    }
    slide.onGainFocus(transitionDuration, this);
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
