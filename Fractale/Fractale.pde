
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
  {"P", "Couleur"}};


// Parametres

//Parametres de fractale
float parametres[][] = {{2, 2}, // Re((zn)^)
  {1, 1}, // Re((zn))^
  {1, 1, 1}, // Re(c)^
  {1, 2, 0}, // Re(c^)
  {0, 0}, //z0
};
boolean Mandel = true;

//Parametres de camera
float echelle = 0.003;
boolean reverseXY = false;
float resolution = 10;

//Parametres couleur
float IntMin = 0;
int iteLimite = 100+int(IntMin);
float maxContraste = 50;
boolean couleurs = false;
int Xcentre, Ycentre;


//Autre
float x = 0;
int seuil = 500;
String nomPara[] = {"Re((zn)^)", "Re((zn))^", "Re(c)^", "Re(c^)", "z0"};
int cd = 10;
boolean HUD = false;
int paraIndice = 0;
int paraIindice = 0;
float oriDepl = 0.05;
boolean menuCommande = false;


void setup() {
  fullScreen();
  Xcentre = int(width*0.5);
  Ycentre = int(height*0.5);
  dessin();
}


void draw() {
  dessin();

  if (cd <= 10) {
    cd ++;
  }

  if (HUD) {

    stroke(200, 20, 20);
    line(width/4, 0, width/4, height);
    line(width*3/4, 0, width*3/4, height);
    line(0, height/4, width, height/4);
    line(0, height*3/4, width, height*3/4);
    fill(0);
    noStroke();
    rect(0, height/4, width/8, height/5);
    fill(200, 20, 20);
    textSize(height/25);

    text(int(resolution), width/1000, height/3.5);
    text(nomPara[paraIndice], width/1000, height/3.1);
    for (int i = 0; i < parametres[paraIndice].length; i ++) {
      if (paraIndice == 4) {
        text( nf(parametres[paraIndice][i], 0, 2), width/1000+i*2*height/20, height/2.7);
      } else {
        text(int(parametres[paraIndice][i]), width/1000+i*2*height/25, height/2.7);
      }
    }
    textSize(height/40);
    text("J : Commandes", width/1000, height/2.4);
  } else if (menuCommande) {

    //Affiche les commandes
    background(0);
    fill(255);
    textSize(height/(commandes.length));
    for (int i = 0; i < commandes.length; i ++) {
      text(commandes[i][0]+" : "+commandes[i][1], width/1000, (i+1)*height/(commandes.length+1));
    }
  }
}


float suite(float r, float i, float seuil, float ite, float cr, float ci) {

  float rInt = r;
  float iInt = i;

  r = pow(pcR(true, rInt, iInt, rInt, iInt, parametres[0][0]), parametres[1][0])
    +parametres[2][2]*pow(cr, parametres[2][0])
    +parametres[3][2]*pcR(true, cr, ci, cr, ci, parametres[3][0]);
  i = pow(pcR(false, rInt, iInt, rInt, iInt, parametres[0][1]), parametres[1][1])
    +parametres[2][2]*pow(ci, parametres[2][1])
    +parametres[3][2]*pcR(false, cr, ci, cr, ci, parametres[3][1]);

  if ( (r*r+i*i) > pow(seuil, 2) || ite > iteLimite) {
    return (ite+1);
  } else {
    return (suite(r, i, seuil, ite+1, cr, ci));
  }
}

int pp = 0;

void dessin() {

  if (x <= width+1) {
    int pa = int(x*100/width);
    if(pa > pp){
      println(pa);
      pp = pa;
    }
   // println(x*100/width);

    for (float y = 0; y < height+1; y += resolution) {
      float tX = (x-Xcentre);
      float tY = (y-Ycentre);
      if (reverseXY) {
        tX = tY;
        tY = (x-Xcentre);
      }
      float r = tX*echelle;
      float i = tY*echelle;
      float s;
      if (Mandel) {
        s = suite(parametres[4][0], parametres[4][1], seuil, 0, r, i);
      } else {
        s = suite(r, i, seuil, 0, parametres[4][0], parametres[4][1]);
      }
      float ni = s;
      noStroke();
      if (couleurs) {
        float ro = 0, ve = 0, bl = 0;
        if (ni <= iteLimite/2) {
          ro = 255;
          ve = (iteLimite/2-ni)*255/(iteLimite/2);
          bl = 0;
        } else if (ni > iteLimite/2 && ni <= iteLimite) {
          ro = iteLimite-ni;
          ve = 0;
          bl = ni - iteLimite/2;
        } else {
          ro = 0;
          ve = 0;
          bl = 0;
        }
        fill(color(ro, ve, bl));
        rect(x, y, resolution, resolution);
      } else {
        fill((ni-IntMin)*255/maxContraste);
        rect(x, y, resolution, resolution);
      }
    }

    x += resolution;
  }
}


void mousePressed() {

  if (HUD) {
    if ( cd > 10) {
      if (mouseX > width/4 && mouseX < width*3/4 && mouseY > height/4 && mouseY < height*3/4) {
        HUD = false;
        x = 0;
      }
    }
  } else {
    if (mouseX > width/4 && mouseX < width*3/4 && mouseY > height/4 && mouseY < height*3/4) {
      HUD = true;
    }
  }
}



void keyPressed() {
  if (HUD) {
    pp = 0;
    switch(keyCode) {
      case(73)://I
      x = 0;
      echelle /= 1.1;
      
      break;

      case(79)://O
      x = 0;
      echelle *= 1.1;
      break;

      case(38)://Haut
      x = 0;
      Ycentre += int(echelle*height*10);
      break;

      case(39)://Droite
      x = 0;
      Xcentre -= int(echelle*width*10);
      break;

      case(40)://Bas
      x = 0;
      Ycentre -= int(echelle*height*10);
      break;

      case(37)://Gauche
      x = 0;
      Xcentre += int(echelle*width*10);
      break;

      case(82)://R
      x = 0;
      if (resolution > 3) {
        resolution -= 3;
      }
      break;

      case(84)://T
      x = 0;
      resolution += 3;
      break;

      case(72):
      HUD = false;
      x = 0;
      break;

      case(67)://C
      if (maxContraste > 1) {
        maxContraste -= 0.5;
        x = 0;
      }
      break;

      case(86)://V
      maxContraste += 0.5;
      x = 0;
      break;

      case(66)://B
      IntMin += 1;
      x = 0;
      break;

      case(78)://N
      IntMin -= 1;
      x = 0;
      break;

      case(81)://Q
      if (paraIndice > 0) {
        paraIndice --;
        paraIindice = 0;
      }
      break;

      case(70)://F
      reverseXY = !reverseXY;
      break;

      case(90)://Z
      if (paraIndice == 4) {
        parametres[paraIndice][paraIindice] += oriDepl;
        x = 0;
      } else {
        parametres[paraIndice][paraIindice] ++;
        x = 0;
      }
      break;

      case(68)://D
      if (paraIndice < nomPara.length-1 ) {
        paraIndice ++;
        paraIindice = 0;
      }
      break;

      case(83)://S
      if (paraIndice == 4) {
        parametres[paraIndice][paraIindice] -= oriDepl;
        x = 0;
      } else {
        if (parametres[paraIndice][paraIindice] > 0) {
          parametres[paraIndice][paraIindice] --;
          x = 0;
        }
      }
      break;

      case(69)://E
      if (paraIindice < parametres[paraIndice].length-1) {
        paraIindice ++;
        x = 0;
      }
      break;

      case(65)://S
      if (paraIindice > 0) {
        paraIindice --;
        x = 0;
      }
      break;

      case(77)://M
      Mandel = !Mandel;
      if (oriDepl == 0.01) {
        oriDepl = 0.05;
      } else {
        oriDepl = 0.01;
      }
      x = 0;
      break;

      case(80)://P
      couleurs = ! couleurs;
      x = 0;
      break;

      case(88)://X
      for (int i = 0; i < parametres.length; i ++) {
        for (int j = 0; j < parametres[i].length; j ++) {
          if (i == 4) {
            parametres[i][j] = random(-1, 1);
          } else if (j == 2) {
            parametres[i][j] = int(random(0, 2));
          } else {
            parametres[i][j] = int(random(2, 7));
          }
          x = 0;
        }
      }
      break;
      
    }
    
  } else {
    
    if (keyCode == 72) {
      HUD = true;
    }
    
  }


  if (keyCode == 87) {//W
    saveFrame("Fractale-"+int(random(10000, 99999))+"-"+str(int(parametres[0][0]))+","+str(int(parametres[0][1]))+","+str(int(parametres[1][0]))+","+str(int(parametres[1][1]))+","+str(int(parametres[2][0]))+","+str(int(parametres[2][1]))+","+str(int(parametres[2][2]))+","+str(int(parametres[3][0]))+","+str(int(parametres[3][1]))+","+str(int(parametres[3][2]))+","+str(int(parametres[4][0]*100))+","+str(int(parametres[4][1]*100))+".png");
    println("Sauvegarde");
  }

  if (keyCode == 74) {//H
    menuCommande = !menuCommande;
    HUD = !menuCommande;
    x = 0;
  }
  
}

float pcR(boolean reel, float r, float i, float rs, float is, float p) {
  if (p <= 1) {
    if (reel) {
      return r;
    } else {
      return i;
    }
  } else {
    return pcR(reel, r*rs-i*is, r*is+rs*i, rs, is, p-1);
  }
}
