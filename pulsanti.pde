 void checkPulsanti(){
 
 if (keyPressed)
  {
    /*
    // movimento camera
   
    if (keyCode == LEFT){
      eyeY -= 0.01;
      //eyeY -= 10;
    }
    if (keyCode == RIGHT){
      eyeY += 0.01;
      //eyeY += 10;
    }*/
    if (keyCode == DOWN){
      eyeR += 5;
    }
    if (keyCode == UP){
      eyeR -= 5;
    }
    /* Movimento palla da pulsante */
    if (key == 'w'){
      z += 5;
    }
    if (key == 's'){
      z -= 5;
    }
    if (key == 'a'){
      x -= 5;
    }
    if (key == 'd'){
      x += 5;
    }
  }
  
  if (mousePressed){
    
   pallaFerma = false;
   alreadyCheck = false;
   attivaLancio = false;
   arrivato = false;
   attivaCinematicaInversa = false;
    
    pushMatrix();
    translate(mouseX, mouseY);
    x = mouseX-width/2;
    y = mouseY-height/2;
    z = 0;
    popMatrix();
  }
}
