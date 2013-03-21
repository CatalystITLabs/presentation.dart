import 'dart:html';
import 'package:presentation/presentation.dart';

num rotatePos = 0;

/// makes a div with overflowing content and a scrollbar
Element testScrollBarContent()
{
  var element = new DivElement();
  element.innerHtml = """
  <p>
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed purus erat, scelerisque nec volutpat sit amet, feugiat ut nibh. Vivamus vitae euismod nunc. Vestibulum aliquam, nulla id laoreet porttitor, dolor elit vestibulum tellus, nec dictum mi sem eget tellus. Fusce venenatis vehicula tincidunt. Sed consequat tempus sagittis. Aliquam pulvinar viverra lacus, fringilla vulputate tortor volutpat eu. Duis sagittis, erat vitae porttitor interdum, leo dui hendrerit ipsum, id mattis nulla orci scelerisque felis. Nunc in velit id nisl viverra mattis. Pellentesque porta nibh ac nulla fringilla in aliquam sem adipiscing. Nulla dapibus gravida convallis.
  </p><p>
  Fusce sed sem ac justo facilisis tincidunt sit amet non urna. Nulla mattis odio eu urna suscipit et lobortis lorem posuere. Nam varius feugiat dui, ac feugiat arcu ullamcorper sit amet. Donec tempus laoreet ante sit amet dictum. Sed vitae nunc purus, et laoreet massa. Fusce felis urna, imperdiet ac commodo nec, tincidunt in est. Suspendisse non justo lectus. Sed suscipit, enim non cursus malesuada, ligula enim scelerisque metus, ut porttitor tortor quam in tellus. Mauris iaculis eros a tortor pharetra euismod. Maecenas in dictum sapien. Vestibulum quis lectus odio.
  </p><p>
  Sed a iaculis metus. Donec mattis ultrices elit, eu pellentesque magna sodales aliquam. Morbi nec mauris nibh. Curabitur quis sem ante, vitae semper sapien. Suspendisse potenti. Proin nec ligula eu elit mattis dapibus. Quisque interdum justo lorem. Vestibulum bibendum adipiscing ligula ut condimentum. Phasellus hendrerit neque a lectus scelerisque placerat. Aliquam quis urna justo. Aliquam vitae massa neque, in facilisis tellus. Curabitur at auctor felis. Vivamus volutpat sagittis sollicitudin. Praesent ante erat, euismod ut molestie id, lobortis quis urna. Praesent ornare turpis quis mi pulvinar placerat.
  </p><p>
  Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras suscipit varius lectus, at faucibus sapien congue vel. Maecenas nec odio a eros dignissim sodales a in quam. Sed ultricies consectetur viverra. Quisque placerat vehicula felis in mollis. Nam sit amet lorem arcu. In ac faucibus nibh. Suspendisse non dolor nunc. Praesent mi arcu, venenatis a faucibus vel, ultrices at nulla. Nunc quis velit augue. Praesent leo diam, faucibus nec facilisis non, viverra at est. Morbi sed justo pretium odio dignissim aliquet. Etiam consectetur placerat erat, a facilisis leo pretium at.
  </p><p>
  Aenean lectus justo, volutpat vitae congue consequat, sodales sed ipsum. Integer eget diam sit amet mauris ullamcorper pharetra. Sed lobortis diam et odio bibendum suscipit. Sed non tellus dolor. Curabitur eget quam purus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer sagittis, felis in euismod aliquet, est erat pretium tellus, a congue leo nunc at dolor.
  </p>""";
  
  element.style.height = "90%";
  element.style.fontSize = "3em";
  return element;
}

/// makes an EmbedElement with another web page
Element testEmbedContent()
{
  var elem = new EmbedElement();
  
  //elem.src="https://github.com/StephenLujan/presentation.dart"; //Github disallows iframes :(
  elem.src="http://stephenlujan.com/";
  //elem.src="http://catalystitservices.com/"; //this site have error in chrome
  elem.width="95%";
  elem.height="90%";
  return elem;
}

void main() {
  //var presentation = new TransitionSlideShow(query("#render"));
  var presentation = new BasicSlideShow(query("#render"));
   
  //Add a series of slides
  presentation.addHtmlSlide("Use the left and right arrow keys.", 1.0, 0.0,   0.0,    20000.0, 0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide2", 1.0, -300.0,0.0,    0.0,     0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide3", 1.0, 300.0, 0.0,    0.0,     0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide4", 1.0, 0.0,   200.0,  0.0,     0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide5", 1.0, 0.0,   -200.0, 0.0,     0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide6", 1.0, 0.0,   0.0,    -800.0,  0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide7", 1.0, -700.0,-150.0, 150.0,   0.0,0.0,90.0);
  presentation.addHtmlSlide("Slide8", 1.0, -100.0,100.0,  150.0,   70.0,0.0,0.0);
  presentation.addHtmlSlide("Slide9", 1.0, 150.0, -300.0, 300.0,   0.0,70.0,0.0);
  presentation.addHtmlSlide("Slide10",1.0, 700.0, 150.0,  300.0,  70.0,70.0,450.0);
  presentation.addElementSlide(testEmbedContent(), 1.0, 400.0, 300.0,  -600.0,   30.0,0.0,360.0);
  presentation.addElementSlide(testScrollBarContent(), 1.0, -500, 500, 500, 0, 0, 0);
  
  var element = new ImageElement();
  element.src = "http://stephenlujan.com/banners/scan4.png";
  presentation.addBackgroundElementSlide(element, 5.0, 0, 1000, -1000, 0, 45, 0);
  
  /*
  presentation.addHtmlSlide("Slide1", 1.0, -300.0,  -300.0, -300.0,  0.0,0.0,0.0);
  presentation.addHtmlSlide("Slide2", 1.0, -300.0,  -300.0, -300.0,  90.0,0.0,0.0);
  presentation.addHtmlSlide("Slide3", 1.0, -300.0,  -300.0, -300.0,  0.0,90.0,0.0);
  presentation.addHtmlSlide("Slide4", 1.0, -300.0,  -300.0, -300.0,  0.0,0.0,90.0);
  presentation.addHtmlSlide("Slide5", 1.0, 400.0,  400.0, 400.0,  90.0,90.0,90.0);
  presentation.addHtmlSlide("Slide6", 1.0, 400.0,  400.0, 400.0,  -90.0,-90.0,-90.0);
  */
  
  presentation.start();

  // Handle key events.
  document.onKeyDown.listen((KeyboardEvent event) {
    switch (event.keyCode) {
      case KeyCode.LEFT:
        presentation.previous();
        break;
      case KeyCode.RIGHT:
        presentation.next();
        break;
    }
    window.scrollTo(0, 0);
  });
}
