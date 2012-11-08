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
    //var xOffset = element.clientWidth ~/ 2;
    //var yOffset = element.clientHeight ~/ 2;
    //element.style.transform = "scale($scale) translateX(${(position.x-xOffset).toInt()}px) translateY(${(position.y-yOffset).toInt()}px) translateZ(${position.z.toInt()}px) rotateX(${rotation.x.toInt()}deg) rotateY(${rotation.y.toInt()}deg) rotateZ(${rotation.z.toInt()}deg)";
    // height and width report as 0 here for some reason
    element.style.transform = this.transformString;
  }

  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7]);
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7]);
}