import g4p_controls.*;

void setup() {
  fullScreen(P3D);
  background(#FADFAE);
  
  /* Condizioni iniziali posizione palla */ 
  x=0;
  y=-height/8;
  z=0;
  
  x0 = x; 
  y0 = y;
  z0 = z;

  randomBallVel();
  createGUI();
}

void draw() {
  
   /*println(pallaFerma+"  "
        +alreadyCheck+ "  "
        +attivaLancio + "  "
        +arrivato + "  "
        +attivaCinematicaInversa);*/
  
  background(#FADFAE);
  smooth();
  lights(); 
  directionalLight(50, 50, 50, 0, 1, 0); 
  // Luce che punta il centro del campo 
  
  camera(width/2.0, height/2.0, eyeR, width/2.0, height/2.0, (height/2.0) / tan(PI*60.0 / 360.0) ,0,1,0);
  
  // Porto il sistema di riferimento al centro dello schermo 
  translate(width/2, height/2, 0);
  
  
  /*rotateY(eyeY); // rotazione camera Y 
  rotateZ(eyeZ); // rotazione camera Z*/
  
  gameField(); //Disegno il campo di gioco 
    
  drawBasket(); //Disegno il canestro 
   
  robot(); //Disegno il robot 
  
  checkPulsanti(); // Pulsanti da tastiera 
  
  if (!attivaLancio){ //Situazione di lancio della palla 
    getBallMotion(); //Dinamica della palla
    bouncingBall(x,y,z);
  }
  else blockedBall(xHand,yHand,zHand); // Palla nella pinza 
  
   /* Variabili di giunto dei robot*/
   q1 = q1-0.05*(q1-q1REF);
   q2 = q2-0.05*(q2-q2REF);
   q3 = q3-0.05*(q3-q3REF); 
      
 /* Se la palla si ferma fai raggiungere al robot la palla e inizia la cinematica inversa*/ 
   if ( pallaFerma && !attivaLancio){ 
    robotMotion(x,z); //muoviti verso la palla 
  }
  
  if (attivaCinematicaInversa == true 
    && spazioOperativo(abs(x-xR-2*r),abs(z-zR-2*r),-y+abs(height/4-r-2*r),scala,scala,scala)
      && !mousePressed && !keyPressed)
  {
    cinematicaInversa(x-xR,z-zR,-y+(height/4-r),1,1,1);
   
    if ( abs(q1-q1REF) <= .0001 && abs(q2-q2REF) <= .0001 && abs(q3-q3REF) <= .0001){ //Se la pinza ha preso la palla
     
    attivaCinematicaInversa = false;
    attivaLancio = true;
    } 
  }

  if (attivaLancio)
    lanciaPalla();
    
}
