part of presentation;

class BasicTransition extends Transition {
  
  BasicTransition(Slide to, Slide from, [num duration = 0.7]) : super(to, from, duration);

  num forward(Camera cam)
  {
    cam.focusOnSlide(to, duration);
    return duration;
  }
  
  num reverse(Camera cam)
  {
    cam.focusOnSlide(from, duration / 2.0);
    return duration / 2.0;
  }
}
