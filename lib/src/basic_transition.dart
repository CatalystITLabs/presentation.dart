part of presentation;

class BasicTransition extends Transition {
  
  BasicTransition(Slide to, Slide from, [num duration = 0.7]) : super(to, from, duration);

  num forward(Camera cam)
  {
    cam.lookAtSlide(to, duration);
    return duration;
  }
  
  num reverse(Camera cam)
  {
    cam.lookAtSlide(from, duration / 2.0);
    return duration / 2.0;
  }
}
