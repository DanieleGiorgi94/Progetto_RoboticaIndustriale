void drawBasket(){
  pushMatrix();
  
  rotateX(PI/2);
  translate(1.1*width/5.0,1.3*(-height/4),-height/4.0); //posizione centro asta canestro 
  /* Coordinate xyz utili per il rimbalzo su di esso */
  xBasket = modelX(0,0,0);
  zBasket = modelZ(0,0,0); 
  stroke(#272928);
  fill(#272928);
  translate(0,0,150); //Mi metto al centro dell'asta del canestro per poterlo disegnare 
  drawCylinder(30,8,300); // Asta del canestro (r=10, h= 300)
  translate(0,0,190); //Punto in cui inserire il tabellone 
  xTab = modelX(0,0,0);
  yTab = modelY(0,0,0);
  zTab = modelZ(0,0,0); 
  rotateZ(PI/6);
  strokeWeight(2);
  fill(255);
  box(100, 10,80); //tabellone bianco
  stroke(0);
  box(50,10,40);
  noFill();
  translate(0,45,-30);
  stroke(#F01313);
  strokeWeight(3);
  arc(0,0, 75, 75, 0, 2*PI); //canestro 
  noFill();
  
  popMatrix();
}

void link(float theta, float d, float alpha, float a){
 
    rotateZ(theta);
    sphere(10);
    translate(0,0,scala*d/2.0);
    box(dx, dy, scala*d);
    translate(0,0,scala*d/2.0);
    rotateX(alpha);
    sphere(15);
    translate(scala*a/2,0,0);
    box(scala*a, dy, dz);
    translate(scala*a/2,0,0); //punta del link 
}


void robot(){
  
    pushMatrix();
       
    translate(xR, height/4-r, zR); //Base del robot (centro faccia superiore carrello)
    
    noStroke();
    rotateX(PI/2);
    
    rotateZ(thetaR); //Il carrello si muove in direzione della cinematica dell'uniciclo
      
    fill(#7D7E7D);//grigio metallico  
    box(cx,cy,cz); //carrello del robot 
    
    //translate(0,0,cz/2);
   // robot antropomorfo disegnato secondo la convenzione di Denavit-Hartenberg 
    link(q1,1.1,PI/2,0);
    link(q2,0,0,1);
    link(q3,0,0,1);
    
   // Disegno la pinza
   translate(-dxp/2,0,0);
   box(dxp,dyp,dzp); 
   translate(-dxp/2,0,0);
   pushMatrix();
   translate(dxp+5,0,dzp/2+1);
   rotateZ(PI/2);
   box(dxp,dzp,dyp/2); // Disegno il primo elemento della pinza
   popMatrix();
   pushMatrix();
   translate(dxp+5,0,-dzp/2+1);
   rotateZ(PI/2);
   box(dxp,dzp,dyp/2); // Disegno il secondo elemento della pinza
   popMatrix();
   translate(dxp+5,0,0);
   xHand = modelX(0,0,0);
   yHand = modelY(0,0,0);
   zHand = modelZ(0,0,0);
 
   popMatrix();
}

void gameField(){
 
  pushMatrix();
  
  stroke(128);
  strokeWeight(5);
  noFill();
  box(width/2, height/2, width/2);
  
  //Disegno il pavimento 
  fill(10,233,133,50); //verde
  rotateX(PI/2);
  translate(0, 0, -height/4);
  rect(-width/4.0, -height/2.5, width/2.0, width/2.0);
  
  popMatrix();
}


void bouncingBall(float xb, float yb, float zb){
 
  pushMatrix();
 
  translate(xb, yb, zb);
  noStroke();
  fill(255, 100, 0);//arancione
  sphere(r); 
  
  popMatrix(); 

}

void blockedBall(float xb, float yb, float zb){
  
  pushMatrix();
  
  translate(-width/2, -height/2, 0);// Torno allo stesso sistema di riferimento del Model
  translate(xb, yb, zb);
  noStroke();
  fill(255, 100, 0);//arancione
  sphere(r); 
  
  popMatrix();   
}


void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);
}
