void lanciaPalla(){
  
  /* Posizione di lancio */
  q2REF = PI/2;
  q3REF = 0;
  
  robotMotion(xR0,zR0);//centro del campo 
 
 
  if (arrivato && abs(q2 - PI/2) <= .01 && abs(q3) <= .01){ /*Il robot è nei pressi del centro del campo: lancia la palla a canestro */
     
          /* Equazioni del moto parabolico */
         
          //xBasket = vx*dt 
          //zBasket = vz*dt;
          //yBasket = yHand +vy*dt +1/2*friction*pow(dt,2); 
                
         vy = -16; //vy < 16.5 altrimenti tocca il soffitto
         dt = (+vy -sqrt(pow(vy,2)-2*friction*(yHand-yTab)))/friction;
         vx = 1.1+(xTab-xHand)/dt;
         vz = -1.1+(zTab-zHand)/dt;
         
         println(dt+"  "+vx+"  "+vz);
         
         x=xR;
         y= -height/8;
         z=zR;
         
         x0 = 0;
         y0 = 0;
         z0 = 0;
         dt =(float) 1/60;
     
     
        pallaFerma = false; //riabilita controlli su palla ferma 
        alreadyCheck = false; 
        attivaLancio = false; //riabilita il movimento della palla
        arrivato = false; //Il robot non si muove più verso la palla
        attivaCinematicaInversa = false; //disattivazione cinematica inversa 

      }
      //else: non sono ancora arrivato nel punto di tiro a canestro

 }


 
   


 
   
