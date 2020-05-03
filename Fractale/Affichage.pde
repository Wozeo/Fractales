
//Commandes

String commandes[][] = {{"Gauche", "Deplace la caméra"}, 
  {"Droite", "Deplace la caméra"}, 
  {"Bas", "Deplace la caméra"}, 
  {"Gauche", "Deplace la caméra"}, 
  {"I", "Zoom"}, 
  {"O", "Dezoom"}, 
  {"H", "Interface"}, 
  {"C", "Eclaircit"}, 
  {"V", "Assombrit"}, 
  {"B", "Augmente le contraste"}, 
  {"N", "Reduit le contraste"}, 
  {"R", "Augmente la résolution"}, 
  {"T", "Réduit la résolution"}, 
  {"W", "Enregistre l'image"}, 
  {"J", "Menu des commandes"}, 
  {"Z", "Augmente le parametre"}, 
  {"S", "Diminue le paramtre"}, 
  {"Q", "Change de parametre"}, 
  {"D", "Change de parametre"}, 
  {"A", "Change de parametre"}, 
  {"E", "Change de parametre"}, 
  {"M", "(z^)+c Modifie si la constante est z ou c"}, 
  {"F", "Echange les axes"}, 
  {"P", "Couleur"}, 
  {"Y", "Active/Desactive le mode 360"}, 
  {"U", "Active/Desactive le mode Lineaire"}};


// Parametres

//Parametres de fractale
float parametres[][] = {{2, 2}, // Re((zn)^)
  {1, 1}, // Re((zn))^
  {1, 1, 0}, // Re(c)^
  {1, 1, 1}, // Re(c^)
  {0, 0}, //z0
  {0}
};
boolean Mandel = true;

//Parametres de camera
float echelle = 0.003;
boolean reverseXY = false;
float resolution = 10;

//Parametres couleur
float IntMin = 0;
int iteLimite = 255;//100
float maxContraste = 50;
int nCoul = 3;
int couleurs = 0;
int Xcentre, Ycentre;


//Autre
float x = 0;
int seuil = 20;//500
String nomPara[] = {"Re((zn)^)", "Re((zn))^", "Re(c)^", "Re(c^)", "z0", "Type"};
int cd = 10;
boolean HUD = false;
int paraIndice = 0;
int paraIindice = 0;
float oriDepl = 0.05;
boolean menuCommande = false;


//360
float multiplicateurAngle = 2;// 1 -> 1 image par degré, 0.5 -> 2 images par degré
float angleMax = 2*PI;
int precisionAngleNom = 5;
boolean tcs = false;

//lineaire
boolean lin = false;
float xDep,yDep,xAr,yAr;
float prcLin = 0;
float deltaLin = 0.005;
int precisionAngleNomLin = 10;

void setup() {
  fullScreen();
  //size(5940, 3240);
  Xcentre = int(width*0.5);
  Ycentre = int(height*0.5);
  dessin();
}

void tcs() {
  String num = str(int(100*angle*180/PI));
  while (num.length() < precisionAngleNom) {
    num = "0"+num;
  }
  saveFrame("Fractale--"+str(int(parametres[0][0]))+"-"+str(int(parametres[0][1]))+"-"+str(int(parametres[1][0]))+"-"+str(int(parametres[1][1]))+"-"+str(int(parametres[2][0]))+"-"+str(int(parametres[2][1]))+"-"+str(int(parametres[2][2]))+"-"+str(int(parametres[3][0]))+"-"+str(int(parametres[3][1]))+"-"+str(int(parametres[3][2]))+"-"+str(int(parametres[5][0]))+"-"+str(int(normetcs*1000))+"/"+num+".png");
  x = 0;
  pp = 0;
  angle += multiplicateurAngle*da;
  parametres[4][0] = normetcs*cos(angle);
  parametres[4][1] = normetcs*sin(angle);
  if (angle > angleMax) {
    tcs = false;
    HUD = true;
  }
  println("360------------------------"+str(100*angle/(angleMax))+"prc--"+str(int(normetcs*1000))+"-"+num+"----------------------------------------");
}

void lin(){
  String num = str(int(1000000*prcLin));
  while (num.length() < precisionAngleNomLin) {
    num = "0"+num;
  }
  saveFrame("Fractale--"+str(int(parametres[0][0]))+"-"+str(int(parametres[0][1]))+"-"+str(int(parametres[1][0]))+"-"+str(int(parametres[1][1]))+"-"+str(int(parametres[2][0]))+"-"+str(int(parametres[2][1]))+"-"+str(int(parametres[2][2]))+"-"+str(int(parametres[3][0]))+"-"+str(int(parametres[3][1]))+"-"+str(int(parametres[3][2]))+"-"+str(int(parametres[5][0]))+"-"+str(int(xAr*1000))+"-"+str(int(yAr*1000))+"/"+num+".png");
  x = 0;
  pp = 0;
  prcLin += deltaLin;
  parametres[4][0] = xDep+(xAr-xDep)*prcLin;
  parametres[4][1] = yDep+(yAr-yDep)*prcLin;
  if (prcLin > 1) {
    lin = false;
    HUD = true;
  }
  println("Lin----------------------------"+str(100*prcLin)+"----"+num+"-----------------------------------------------------------------");
}


float suite(float r, float i, float seuil, float ite, float cr, float ci) {

  float rInt = r;
  float iInt = i;



  /*Type1*/


  switch(int(parametres[5][0])) {


    case(1)://Type 1
    r = 0;
    i = 0;
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pow(-1, k)*pcR(true, rInt, iInt, rInt, iInt, k);

        i += pow(-1, k)*pcR(false, rInt, iInt, rInt, iInt, k);
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;





    case(2)://Type 2
    if (cr == 0 && ci == 0) {
      return ite+1;
    }
    float cpr = pcR(true, cr, ci, cr, ci, int(parametres[1][0]));
    float cpi = pcR(false, cr, ci, cr, ci, int(parametres[1][1]));
    float rIntp = pcR(true, rInt, iInt, rInt, iInt, int(parametres[0][0]));
    float iIntp = pcR(false, rInt, iInt, rInt, iInt, int(parametres[0][1]));
    r = cosCpl(true, rIntp, iIntp)+invCpl(true, cpr, cpi);
    i = cosCpl(false, rIntp, iIntp)+invCpl(false, cpr, cpi);
    break;




    case(3)://Type 3
    if (cr == 0 && ci == 0) {
      return ite+1;
    }
    cpr = pcR(true, cr, ci, cr, ci, int(parametres[1][0]));
    cpi = pcR(false, cr, ci, cr, ci, int(parametres[1][1]));

    r = shCpl(true, cpr, cpi) + pcR(true, rInt, iInt, rInt, iInt, parametres[0][0]);
    i = shCpl(false, cpr, cpi) + pcR(false, rInt, iInt, rInt, iInt, parametres[0][1]);
    break;



    case(4)://Type 4
    if (cr == 0 && ci == 0) {
      return ite+1;
    }
    cpr = pcR(true, cr, ci, cr, ci, int(parametres[0][0]));
    cpi = pcR(false, cr, ci, cr, ci, int(parametres[0][1]));
    r = sinCpl(true, rInt, iInt)+invCpl(true, cpr, cpi);
    i = sinCpl(false, rInt, iInt)+invCpl(false, cpr, cpi);
    break;



    case(5)://Type 5
    if (cr == 0 && ci == 0) {
      return ite+1;
    }
    cpr = pcR(true, cr, ci, cr, ci, int(parametres[1][0]));
    cpi = pcR(false, cr, ci, cr, ci, int(parametres[1][1]));

    r = chCpl(true, cpr, cpi) + pcR(true, rInt, iInt, rInt, iInt, parametres[0][0]);
    i = chCpl(false, cpr, cpi) + pcR(false, rInt, iInt, rInt, iInt, parametres[0][1]);
    break;

    case(6)://Type 6 : Burning Ship
    rIntp = (abs(rInt));
    iIntp = (abs(iInt));
    r = pcR(true, rIntp, iIntp, rIntp, iIntp, parametres[0][0]) + pcR(true, cr, ci, cr, ci, parametres[3][0]);
    i = pcR(false, rIntp, iIntp, rIntp, iIntp, parametres[0][1]) + pcR(false, cr, ci, cr, ci, parametres[3][1]);
    break;

    case(7)://Type 7
    rIntp = chCpl(true, abs(rInt), abs(iInt));//(abs(rInt));
    iIntp = chCpl(false, abs(rInt), abs(iInt));//(abs(iInt));
    r = pcR(true, rIntp, iIntp, rIntp, iIntp, parametres[0][0]) + pcR(true, cr, ci, cr, ci, parametres[3][0]);
    i = pcR(false, rIntp, iIntp, rIntp, iIntp, parametres[0][1]) + pcR(false, cr, ci, cr, ci, parametres[3][1]);
    break;

    case(8)://Type 8
    r = 0;
    i = 0;
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pow(-1, k)*pcR(true, rInt, iInt, rInt, iInt, k)/k;
        i += pow(-1, k)*pcR(false, rInt, iInt, rInt, iInt, k)/k;
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;
    
    case(9)://Type 9
    r = 0;
    i = 0;
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pow(-1, k)*pcR(true, rInt, iInt, rInt, iInt, k)/factorielle(k);
        i += pow(-1, k)*pcR(false, rInt, iInt, rInt, iInt, k)/factorielle(k);
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;
    
    case(10)://Type 10
    r = 0;
    i = 0;
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pcR(true, rInt, iInt, rInt, iInt, k)/k;
        i += pcR(false, rInt, iInt, rInt, iInt, k)/k;
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;
    
    case(11)://Type 11
    r = 0;
    i = 0;
    rIntp = chCpl(true, abs(rInt), abs(iInt));
    iIntp = chCpl(false, abs(rInt), abs(iInt));
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pcR(true, rIntp, iIntp, rIntp, iIntp, k)/(k);
        i += pcR(false, rIntp, iIntp, rIntp, iIntp, k)/(k);
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;
    
    case(12)://Type 12
    r = 0;
    i = 0;
    rIntp = cosCpl(true, abs(rInt), abs(iInt));
    iIntp = cosCpl(false, abs(rInt), abs(iInt));
    for (int k = 0; k <= parametres[0][0]; k ++) {
      if (k !=1 && k != 0) {
        r += pcR(true, rIntp, iIntp, rIntp, iIntp, k)/(k);
        i += pcR(false, rIntp, iIntp, rIntp, iIntp, k)/(k);
      } else if (k == 0) {
        r += cr;
        i += ci;
      }
    }
    break;

    case(0):
    r = pow(pcR(true, rInt, iInt, rInt, iInt, parametres[0][0]), parametres[1][0])
      +parametres[2][2]*pow(cr, parametres[2][0])
      +parametres[3][2]*pcR(true, cr, ci, cr, ci, parametres[3][0]);
    i = pow(pcR(false, rInt, iInt, rInt, iInt, parametres[0][1]), parametres[1][1])
      +parametres[2][2]*pow(ci, parametres[2][1])
      +parametres[3][2]*pcR(false, cr, ci, cr, ci, parametres[3][1]);
    break;
  }





  if ( (r*r+i*i) > pow(seuil, 2) || ite > iteLimite+IntMin) {
    return (ite+1);
  } else {
    return (suite(r, i, seuil, ite+1, cr, ci));
  }
}



int pp = 0;
float normetcs = 0;
float angle = 0;
float da = PI/180.0;
