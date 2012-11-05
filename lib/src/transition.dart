part of presentation;

abstract class Transition {
  Slide to;
  Slide from;
  num duration;
  
  Transition (this.to, this.from, [this.duration = 0.7]);
  
  /**
   * Play this transition forward
   */
  num forward(Camera cam);
  
  /**
   * Play this transition in reverse
   */
  num reverse(Camera cam);
}
