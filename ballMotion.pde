void getBallMotion(){
 
  // Controllo del rimbalzo sulle pareti della "scatola" di gioco  
   vy += 1;
   x += vx;
   y += vy;
   z += vz;  
   
  if (x>(width/4)) {
    x= width/4;
    vx *= friction;
  }
  else if ( x<-(width/4) ){
     x = -(width/4);
     vx *= friction;
  }
  if (y>(-r+height/4)) {
    y= -r+height/4;
    vy *= friction;
    vx *=.9600; //Per far fermare la palla più velocemente quando "rotola" sul pavimento (x,z)
    vz *=.9600;
  }
  
  else if ( y<(-r-height/4)){
    y = r-height/4;
    vy *= friction;
  }
  
  if (z>(width/4)) {
    z=(width/4);
    vz *= friction;
  }
  else if(z<-(width/4.0)){
    z = -width/4;
    vz *= friction;
  }
  
   // Controllo se la palla si è fermata 
   if (abs(x-x0) <= .01 && abs(z-z0) <= .01 && abs(y-y0) <= .01 && !alreadyCheck){
       pallaFerma = true;
       alreadyCheck = true;
   }
 
   x0 = x;
   y0 = y;
   z0 = z; 
 
}

void randomBallVel(){
  /* Lancio aleatorio della palla  */
    vx = random(-20, 20);
    vy = random(-20, 20);
    vz = random(-20, 20);
}
