part of presentation;

/**
 * A slide of content for presentation.
 */
class Slide extends Object {
  Element element;
  
  Slide(this.element, num scale, num x, num y, num z, num h, num p, num r) : super(scale, x, y, z, h, p, r)
  {
    this.element.classes.add("object");
    this.element.style
    ..position = "absolute"
    ..transformStyle = "preserve-3d";
    this.setTransform();
  }

  setTransform()
  {
    element.style.transform =  this.transformString;
  }

  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus();
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus();
}