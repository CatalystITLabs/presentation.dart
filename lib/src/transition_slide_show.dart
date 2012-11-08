part of presentation;

/**
 * The TransitionSlideShow class transitions through a series of slides and maintains them as a 3d scene.
 */
class TransitionSlideShow extends SlideShow
{
  List<Transition> transitions = new List<Transition>();
  int currentTransitionIndex = 0;
  Slide currentSlide;
  
  TransitionSlideShow(Element viewBox): super(viewBox);
  
  void next()
  {
    if (transitions.length < 1)
      return;
    print("next");
    var transition = this.transitions[currentTransitionIndex];
    var duration = transition.forward(cam);
    currentSlide = transition.to;
    this.highlightSlide(this.currentSlide, duration);
    
    currentTransitionIndex++;
    if (currentTransitionIndex >= transitions.length)
      currentTransitionIndex = 0;
  }
  
  void previous()
  {
    if (transitions.length < 1)
      return;
    print("previous");
      
    var transition = this.transitions[currentTransitionIndex];
    var duration = transition.reverse(cam);
    currentSlide = transition.from;
    highlightCurrentSlide(duration);
    
    currentTransitionIndex--;
    if (currentTransitionIndex < 0)
      currentTransitionIndex =  transitions.length-1;
  }
 
  void useDefaultTransitions()
  {
    this.transitions.clear();
    if (slides.length > 1)
    {
      //slides.last was not returning a Slide type
      var lastSlide = slides[slides.length-1];
      for (var slide in this.slides)
      {
        var transition = new BasicTransition(slide, lastSlide);
        lastSlide = slide;
        transitions.add(transition);
      }
    }
  }
  
  void start()
  {
    if (transitions.length == 0 && slides.length > 1)
      useDefaultTransitions();
    if (transitions.length > 0)
      next();
  }
}