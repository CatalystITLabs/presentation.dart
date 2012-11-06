part of presentation;

class BasicTransition extends Transition {
  
  BasicTransition(Slide to, Slide from, [num duration = 0.7]) : super(to, from, duration);
  
  void _focusSlide(Camera cam, Slide slide, num time)
  {
    //focus on the center of the slide
    var xOffset = slide.element.clientWidth ~/ 2;
    var yOffset = slide.element.clientHeight ~/ 2;
    cam.move( time, slide.position.x + xOffset, slide.position.y + yOffset, slide.position.z + yOffset, slide.rotation.x, slide.rotation.y, slide.rotation.z);
  }

  num forward(Camera cam)
  {
    this._focusSlide(cam, to, duration);
    return duration;
  }
  
  num reverse(Camera cam)
  {
    this._focusSlide(cam, from, duration / 2.0);
    return duration / 2.0;
  }
}
