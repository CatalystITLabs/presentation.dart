library presentation;
import 'dart:html';
import 'dart:math';
part "src/vec3.dart";
part "src/object.dart";
part "src/slide.dart";
part "src/camera.dart";
part "src/transition.dart";
part "src/basic_transition.dart";

/**
 * The Presentation class transitions through a series of slides and maintains them as a 3d scene.
 */
class Presentation
{
  List<Slide> slides = new List<Slide>();
  List<Transition> transitions = new List<Transition>();
  int currentTransitionIndex = 0;
  Slide currentSlide;
  Camera cam;
  
  Presentation(Element viewBox)
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
  Slide addHtmlSlide(String Html, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromHtml(Html, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slide.element);
    this.slides.add(slide);
    return slide;
  }
  
  /**
   * Creates a new Slide object from a DOM element and adds it to the end of the presentation
   */
  Slide addElementSlide(Element slideElement, num scale, num x, num y, num z, num h, num p, num r)
  {
    var slide = makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slideElement);
    this.slides.add(slide);
    return slide;
  }
  
  /**
   * Moves the virtual camera over the current slide.
   * You can optionally specify how long it takes to transition to this slide.
   */
  void highlightCurrentSlide([num transitionDuration = 0.7])
  { 
    for(var slide in this.slides)
    {
      slide.element.style
      //..transitionDuration = "${transitionDuration}s"
      ..transition ="opacity ${transitionDuration}s ease-in-out"
      ..opacity = "0.4";
    }
    var slide = this.currentSlide;
    slide.element.style.opacity = "1.0";
  }
  
  void next()
  {
    if (transitions.length < 1)
      return;
    print("next");
    var transition = this.transitions[currentTransitionIndex];
    var duration = transition.forward(cam);
    currentSlide = transition.to;
    highlightCurrentSlide(duration);
    
    currentTransitionIndex++;
    if (currentTransitionIndex >= transitions.length)
      currentTransitionIndex = 0;
  }
  
  void previous()
  {
    if (transitions.length < 1)
      return;
    print("previous");
      
    var transition = this.transitions[currentTransitionIndex];
    var duration = transition.reverse(cam);
    currentSlide = transition.from;
    highlightCurrentSlide(duration);
    
    
    currentTransitionIndex--;
    if (currentTransitionIndex < 0)
      currentTransitionIndex =  transitions.length-1;
  }
 
  void useDefaultTransitions()
  {
    this.transitions.clear();
    if (slides.length > 1)
    {
      //slides.last was not returning a Slide type
      var lastSlide = slides[slides.length-1];
      for (var slide in this.slides)
      {
        var transition = new BasicTransition(slide, lastSlide);
        lastSlide = slide;
        transitions.add(transition);
      }
    }
  }
  
  void start()
  {
    if (transitions.length == 0 && slides.length > 1)
      useDefaultTransitions();
    if (transitions.length > 0)
      next();
  }
}