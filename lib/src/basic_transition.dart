part of presentation;

class BasicTransition extends Transition {
  
  BasicTransition(Slide to, Slide from, [num duration = 0.7]) : Transition (to, from, duration);
  
  void _focus(Camera cam, Object object, num time)
  {
    //focus on the center of the slide
    var xOffset = slide.element.clientWidth ~/ 2;
    var yOffset = slide.element.clientHeight ~/ 2;
    cam.move( time, to.position.x + xOffset, to.position.y + yOffset, to.position.z + yOffset, to.rotation.x, to.rotation.y, to.rotation.z);
  }

  num forward(Camera cam)
  {
    this._focus(cam, to, duration);
    return duration;
  }
  
  num reverse(Camera cam)
  {
    this._focus(cam, from, duration / 2.0);
    return duration / 2.0;
  }
}
