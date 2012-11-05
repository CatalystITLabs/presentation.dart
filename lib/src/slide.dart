part of presentation;

/**
 * A slide of content for presentation.
 */
class Slide extends Object {
  Element element;
  
  Slide(this.element, double scale, double x,double y,double z,double h,double p,double r) : super(scale, x, y, z, h, p, r)
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
}