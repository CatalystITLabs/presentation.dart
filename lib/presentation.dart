library presentation;
import 'dart:html';
import 'dart:math';
part "vec3.dart";
part "object.dart";
part "slide.dart";
part "camera.dart";

/**
 * The Presentation class transitions through a series of slides and maintains them as a 3d scene.
 */
class Presentation
{
  List<Slide> slides = new List<Slide>();
  int currentSlideIndex = 0;
  Camera cam;
  
  Presentation(Element viewBox, Element scene)
  {
    this.cam = new Camera(viewBox, scene);
  }
  
  /**
   * Creates a new Slide object from a String of html
   */
  static Slide makeSlideFromHtml(String Html, double scale, double x, double y, double z, double h, double p, double r)
  {
    var slideElement = new DivElement();
    slideElement.innerHTML = Html;
    slideElement.style.height = "1px";
    slideElement.style.width = "1px";
    return makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
  }
  
  /**
   * Creates a new Slide object from a DOM element
   */
  static Slide makeSlideFromElement(Element slideElement, double scale, double x, double y, double z, double h, double p, double r)
  {
    return new Slide(slideElement, scale,x,y,z,h,p,r);
  }
  
  /**
   * Creates a new Slide object from a String of html and adds it to the end of the presentation
   */
  void addHtmlSlide(String Html, double scale, double x, double y, double z, double h, double p, double r)
  {
    var slide = makeSlideFromHtml(Html, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slide.element);
    this.slides.add(slide);
  }
  
  /**
   * Creates a new Slide object from a DOM element and adds it to the end of the presentation
   */
  void addElementSlide(Element slideElement, double scale, double x, double y, double z, double h, double p, double r)
  {
    var slide = makeSlideFromElement(slideElement, scale, x, y, z, h, p, r);
    this.cam.scene.insertAdjacentElement("beforeEnd", slideElement);
    this.slides.add(slide);
  }
  
  /**
   * Moves the virtual camera over the current slide.
   */
  void focusCurrentSlide()
  {
    
    /*
    TODO: focus on center of slide
    var boundary = this.element.getBoundingClientRect();
    x = renderwidth / 2 - boundary.width;
    y = renderHeight / 2 - boundary.height;
    */
    var slide = this.slides[currentSlideIndex];
    //var xOffset = slide.element.clientWidth ~/ 2;
    //var yOffset = slide.element.clientHeight ~/ 2;
    var xOffset = 0;
    var yOffset = 0;
    print (xOffset);
    print (yOffset);
    this.cam.move(slide.position.x + xOffset, slide.position.y + yOffset, slide.position.z+ yOffset, slide.rotation.x, slide.rotation.y, slide.rotation.z);
  }
  
  /**
   * Advances the presentation to the next slide.
   */
  void next()
  {
    if (slides.length < 1)
      return;
    print("next");
    currentSlideIndex++;
    if (currentSlideIndex >= slides.length)
      currentSlideIndex = 0;
    focusCurrentSlide();
  }
  
  /**
   * Returns the presentation to the previous slide.
   */
  void previous()
  {
    if (slides.length < 1)
      return;
    print("previous");
    currentSlideIndex--;
    if (currentSlideIndex < 0)
      currentSlideIndex = slides.length - 1;
    focusCurrentSlide();
  }
  
}