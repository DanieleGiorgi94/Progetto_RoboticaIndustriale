void robotMotion(float xdes, float zdes){ //Migliorare che deve arrivarci gradualmente e non fermarsi di colpo! 
    
  if (!attivaLancio){ //CASO 1: il robot raggiunge la palla
    
   //translate(x,y,z);
   
  /* Il robot raggiunge la palla fintanto che non ha raggiunto il suo spazio operativo */
  if (!spazioOperativo(abs(xdes-xR-2*r),abs(zdes-zR-2*r),-y+abs((height/4-r)-2*r), scala,scala,scala))
  {
    tempo = (millis()-t0)/1000; // tempo missione
  
    // assegno velocità secondo legge proporzionale
    v1 = kv1*((xdes-xR)*cos(thetaR) + (zdes-zR)*sin(thetaR)); 

    // Calcolo l'angolo verso il target: scelgo il multiplo di 2PI 
    // più vicino all'orientamento corrente del robot
    thetaDes = atan2(zdes-zR,xdes-xR) + nGiri*2*PI;
    if (abs(thetaDes+2*PI-thetaR) < abs(thetaDes-thetaR))
    {
      thetaDes = thetaDes+2*PI;
      nGiri += 1;
    }
    else
    {
      if (abs(thetaDes-2*PI-thetaR) < abs(thetaDes-thetaR))
      {
        thetaDes = thetaDes-2*PI;
        nGiri += -1;
      }
    }
    // assegno velocità angolare secondo legge proporzionale    
    v2 = kv2*(thetaDes-thetaR);
  }
  else{
 // se sono già abbastanza vicino al target azzero le mie velocità (traslazionale - angolare )
    v1 = 0;
    v2 = 0;
    
    if (!attivaLancio)
      attivaCinematicaInversa = true;
  }
   
 /* Evito che il carrello del robot vada oltre le pareti del campo: 
    se le raggiungo, lo faccio muovere di moto rettilineo */ 
   if (xR+cx>(width/4) ) 
      xR = xR-0.05*(xR-x); 
  
  else if ( xR+cx<-(width/4) ){
     xR = xR-0.05*(xR-x);
  }
  else xR = xR + v1*cos(thetaR)*dt; // Equazione cinematica uniciclo 
       
  if (zR+cz>(width/4)) {
    zR = zR-0.05*(zR-z);
  }
  else if (zR+cz<-(width/4)){
      zR = zR-0.05*(zR-z);
  }  
  else zR = zR + v1*sin(thetaR)*dt; 
 
  thetaR = thetaR + v2*dt;
 
// Calcolo velocità angolare ruote e loro accelerazioni
  omegaRp = ((v1+v2*d/2)/rRuote-omegaR)/dt;
  omegaLp = ((v1-v2*d/2)/rRuote-omegaL)/dt;
  omegaR = (v1+v2*d/2)/rRuote;
  omegaL = (v1-v2*d/2)/rRuote;
  
  
  }else  // CASO 2: Il robot raggiunge la destinazione prefissata in direzione del canestro 
    {
     
     e_p = sqrt(pow(xdes-xR,2)+pow(zdes-zR,2));
     if (e_p > 3) // mi muovo solo se l'errore è maggiore di una certa quantità
    {
      tempo = (millis()-t0)/1000; // tempo missione
    
      // assegno velocità secondo legge proporzionale
      v1 = kv1*((xdes-xR)*cos(thetaR) + (zdes-zR)*sin(thetaR)); 
  
     
      thetaDes = atan2(zdes-zR,xdes-xR) + nGiri*2*PI;

      if (abs(thetaDes+2*PI-thetaR) < abs(thetaDes-thetaR))
      {
        thetaDes = thetaDes+2*PI;
        nGiri += 1;
      }
      else
      {
        if (abs(thetaDes-2*PI-thetaR) < abs(thetaDes-thetaR))
        {
          thetaDes = thetaDes-2*PI;
          nGiri += -1;
        }
      }
      // assegno velocità angolare secondo legge proporzionale    
      v2 = kv2*(thetaDes-thetaR);
     
    }
    else{
   // mi fermo e oriento il robot in direzione del canestro 
      v1 = 0;
      if (abs(atan2(-height/4.0,1.1*width/5.0)-PI/9+ nGiri*2*PI-thetaR) >= .01){
          thetaDes = atan2(-height/4.0,1.1*width/5.0)-PI/9+ nGiri*2*PI;
           v2 = kv2*(thetaDes-thetaR);
           thetaR = thetaR + v2*dt;
     
          return; // esco dalla funzione: arrivato resta false
      }
      arrivato = true; //posso iniziare il lancio verso il canestro
    } 
    
  // Equazione cinematica uniciclo  
  xR = xR + v1*cos(thetaR)*dt;
  zR = zR + v1*sin(thetaR)*dt;
  thetaR = thetaR + v2*dt;
 

  // Calcolo velocità angolare ruote e loro accelerazioni
  omegaRp = ((v1+v2*d/2)/r-omegaR)/dt;
  omegaLp = ((v1-v2*d/2)/r-omegaL)/dt;
  omegaR = (v1+v2*d/2)/r;
  omegaL = (v1-v2*d/2)/r;
  }

}


boolean spazioOperativo(float x, float y, float z, float L1, float L2, float L3){
  float t = pow(x,2)+pow(y,2)+pow(z-L1,2);
      if (pow(L2-L3-r,2) < t && t < pow(L2+L3-r,2)) 
        return true;
      else return false;
}

void cinematicaInversa(float xdes, float ydes, float zdes, float L1, float L2, float L3){
  
  float Y,X,a,A,b1,b2;
 
        Y = zdes-L1*scala;
        X = sqrt(pow(xdes,2)+pow(ydes,2));
        a = (pow(X,2)+pow(Y,2)-pow(L2*scala,2)-pow(L3*scala,2))/(2*L1*scala*L3*scala);
        A = -sqrt(1-pow(a,2));
        q1REF = atan2(ydes,xdes)-thetaR+nGiri*2*PI;
        q3REF = atan2(A, a);
        b1 = scala+cos(q3REF)*scala;
        b2 = sin(q3REF)*scala;
        q2REF = atan2(-b2*X+b1*Y, b1*X+b2*Y);
    
}
