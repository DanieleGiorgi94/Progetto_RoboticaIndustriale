float eyeR = 800; // distanza della camera
float eyeZ = 0;
float eyeY = 0;

// Coordinate della palla 
float x = width/2;
float y = height/2;
float z = 0;

int r = 15; //raggio palla 

//Posizione iniziale x,y,z del robot (sul pavimento del campo da gioco) 
float xR = 0;
float yR = height/4-r;
float zR = 0;
float thetaR = 0;

float xR0 = 0;
float zR0 = 0;

boolean arrivato = false;
boolean pallaFerma = false;
boolean alreadyCheck = false;

float kp = 0.020;

float security = 75;

float x0, y0, z0;

// ball speeds
float vx,vy,vz;

float friction = -0.8;

// cordinate di giunto
float q1 = 0;
float q2 = 0;
float q3 = 0;

// dimensioni link
float dx = 15;
float dy = 15;
float dz = 15;

// dimensioni carrello 
int cx = 70; //larghezza 
int cy = 60; //profondità 
int cz = 20; //altezza 

// dimensioni pinza 
float dxp = 20;
float dyp = 20;
float dzp = 35; //profondità 

// Caratteristiche fisiche uniciclo
float rRuote =cz/2; // raggio ruote in pixel
float d = cy; // distanza tra le ruote in pixel
float W = cz; // spessore ruota in pixel

float dt = (float) 1/60; // tempo di campionamento

float e_p = 0; // errore posizionamento
float ep_0 = 0; 
float v1 = 0; // velocità lineare robot
float kv1 = 0.9; // costante legge proporzionale controllo v1 (N.B: se Kv1 = 60, vado instantaneamente al punto, se Kv1 > 60 supero il punto, se Kv1 = 120 oscillo all'infinito! ) 
float v2 = 0; // velocità rotazionale robot
float kv2 = 1.5;  // costante legge proporzionale controllo v2 (se Kv2 = 60, si orienta istantaneamente)
int nGiri = 0; // conta quanti giri su se stesso ha fatto il robot
float thetaDes; // orientamento desiderato (per raggiungere il target)
float t0,tempo; // tempo inizio e attuale missione

float omegaR = 0; // velocità angolare ruota destra
float omegaL = 0; // velocità angolare ruota sinistra
float omegaRp, omegaLp; // accelerazioni angolari ruote

boolean attivaCinematicaInversa = false;
boolean attivaLancio = false;

float xHand,yHand,zHand; //Coordinate del centro della pinza del robot 

float xBasket,yBasket,zBasket;
float xTab,yTab,zTab;

float dist = 0;
float scala = 80.0;

float L1 = 1;
float L2 = 1;
float L3 = 1;

float q1REF, q2REF, q3REF = 0;
