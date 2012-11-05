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
  int currentSlideIndex = 0;
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
   * Moves the virtual camera over the current slide.
   * You can optionally specify how long it takes to transition to this slide.
   */
  void focusCurrentSlide([num transitionDuration = 0.7])
  { 
    for(var slide in this.slides)
    {
      slide.element.style
      //..transitionDuration = "${transitionDuration}s"
      ..transition ="opacity ${transitionDuration}s ease-in-out"
      ..opacity = "0.4";
    }
    var slide = this.slides[currentSlideIndex];
    slide.element.style.opacity = "1.0";
   
    //focus on the center of the slide
    var xOffset = slide.element.clientWidth ~/ 2;
    var yOffset = slide.element.clientHeight ~/ 2;
    this.cam.move( transitionDuration, slide.position.x + xOffset, slide.position.y + yOffset, slide.position.z + yOffset, slide.rotation.x, slide.rotation.y, slide.rotation.z);
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