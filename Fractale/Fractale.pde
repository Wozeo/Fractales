
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
  {"Y", "Active/Desactive le mode 360"}};


// Parametres

//Parametres de fractale
float parametres[][] = {{2, 2}, // Re((zn)^)
  {1, 1}, // Re((zn))^
  {1, 1, 0}, // Re(c)^
  {1, 1, 1}, // Re(c^)
  {0, 0}, //z0
};
boolean Mandel = true;

//Parametres de camera
float echelle = 0.003;
boolean reverseXY = false;
float resolution = 10;

//Parametres couleur
float IntMin = 0;
int iteLimite = 100+int(IntMin);//100
float maxContraste = 50;
int nCoul = 3;
int couleurs = 0;
int Xcentre, Ycentre;


//Autre
float x = 0;
int seuil = 500;//500
String nomPara[] = {"Re((zn)^)", "Re((zn))^", "Re(c)^", "Re(c^)", "z0"};
int cd = 10;
boolean HUD = false;
int paraIndice = 0;
int paraIindice = 0;
float oriDepl = 0.05;
boolean menuCommande = false;
boolean tcs = false;

//360
float multiplicateurAngle = 2;// 1 -> 1 image par degré, 0.5 -> 2 images par degré
float angleMax = PI;
int precisionAngleNom = 5;

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
  saveFrame("Fractale--"+str(int(parametres[0][0]))+"-"+str(int(parametres[0][1]))+"-"+str(int(parametres[1][0]))+"-"+str(int(parametres[1][1]))+"-"+str(int(parametres[2][0]))+"-"+str(int(parametres[2][1]))+"-"+str(int(parametres[2][2]))+"-"+str(int(parametres[3][0]))+"-"+str(int(parametres[3][1]))+"-"+str(int(parametres[3][2]))+"-"+str(int(normetcs*1000))+"/"+num+".png");
  x = 0;
  pp = 0;
  angle += multiplicateurAngle*da;
  parametres[4][0] = normetcs*cos(angle);
  parametres[4][1] = normetcs*sin(angle);
  if (angle > angleMax) {
    tcs = false;
    HUD = true;
  }
  println("360------------------------"+str(100*angle*180/(PI*360))+"prc--"+str(int(normetcs*1000))+"-"+num+"----------------------------------------");
}


float suite(float r, float i, float seuil, float ite, float cr, float ci) {

  float rInt = r;
  float iInt = i;



  /*Type1*/
  boolean nonClassique = true;
  int typeFr = 4;
  if (nonClassique) {
    switch(typeFr) {


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
      float cpr = pcR(true, cr, ci, cr, ci, int(parametres[0][0]));
      float cpi = pcR(false, cr, ci, cr, ci, int(parametres[0][1]));
      r = cosCpl(true, rInt, iInt)+invCpl(true, cpr, cpi);
      i = cosCpl(false, rInt, iInt)+invCpl(false, cpr, cpi);
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
      cpr = pcR(true, cr, ci, cr, ci, int(parametres[0][0]));
      cpi = pcR(false, cr, ci, cr, ci, int(parametres[0][1]));
      r = cosCpl(true, rInt, iInt)+invCpl(true, cpr, cpi);
      i = cosCpl(false, rInt, iInt)+invCpl(false, cpr, cpi);
      break;
      
      
      
    }
  } else {//Classique
    r = pow(pcR(true, rInt, iInt, rInt, iInt, parametres[0][0]), parametres[1][0])
      +parametres[2][2]*pow(cr, parametres[2][0])
      +parametres[3][2]*pcR(true, cr, ci, cr, ci, parametres[3][0]);
    i = pow(pcR(false, rInt, iInt, rInt, iInt, parametres[0][1]), parametres[1][1])
      +parametres[2][2]*pow(ci, parametres[2][1])
      +parametres[3][2]*pcR(false, cr, ci, cr, ci, parametres[3][1]);
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
