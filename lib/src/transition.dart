part of presentation;

///Transition from one slide to another
abstract class Transition {
  Slide to;
  Slide from;
  num duration;
  
  Transition (Slide this.to, Slide this.from, [num this.duration = 0.7]);
  
  ///Play this transition forward
  num forward(Camera cam);
  
  ///Play this transition in reverse
  num reverse(Camera cam);
}
