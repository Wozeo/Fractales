


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
      x = 0;
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
      if (oriDepl == 0.001) {
        oriDepl = 0.05;
      } else {
        oriDepl = 0.001;
      }
      x = 0;
      break;

      case(80)://P
      //couleurs = ! couleurs;
      couleurs ++;
      couleurs = couleurs%nCoul;
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

      case(89)://Y

      float zox = parametres[4][0];
      float zoy = parametres[4][1];
      float norme = sqrt(zox*zox+zoy*zoy);
      if (norme > 0) {
        tcs = !tcs;
        normetcs = norme;
        angle = 0;
        x = 0;
        parametres[4][0] = norme;
        parametres[4][1] = 0;
        HUD = false;
      }
      break;
      
      case(85):
      lin = !lin;
      HUD = false;
      x = 0;
      xDep = 0; 
      yDep = 0;
      xAr = parametres[4][0];
      yAr = parametres[4][1];
      parametres[4][0] = xDep;
      parametres[4][1] = xAr;
      break;
    }
  } else {

    if (keyCode == 72) {
      HUD = true;
    }
  }
  println(keyCode);


  if (keyCode == 87) {//W
    saveFrame("Fractale-"+int(random(10000, 99999))+"-"+str(int(parametres[0][0]))+","+str(int(parametres[0][1]))+","+str(int(parametres[1][0]))+","+str(int(parametres[1][1]))+","+str(int(parametres[2][0]))+","+str(int(parametres[2][1]))+","+str(int(parametres[2][2]))+","+str(int(parametres[3][0]))+","+str(int(parametres[3][1]))+","+str(int(parametres[3][2]))+","+str(int(parametres[4][0]*100))+","+str(int(parametres[4][1]*100))+","+str(int(parametres[5][0]))+".png");
    println("Sauvegarde");
  }

  if (keyCode == 74) {//H
    menuCommande = !menuCommande;
    HUD = !menuCommande;
    x = 0;
  }
  println("----Paramètres----");
  println(str(int(parametres[0][0]))+","+str(int(parametres[0][1]))+","+str(int(parametres[1][0]))+","+str(int(parametres[1][1]))+","+str(int(parametres[2][0]))+","+str(int(parametres[2][1]))+","+str(int(parametres[2][2]))+","+str(int(parametres[3][0]))+","+str(int(parametres[3][1]))+","+str(int(parametres[3][2]))+","+str(int(parametres[4][0]*1000))+","+str(int(parametres[4][1]*1000)));
  println("Echelle : "+echelle);
  println("Xcentre : "+Xcentre);
  println("Ycentre : "+Ycentre);
  println("Resolution : "+resolution);
  println("Contraste : "+maxContraste);
  println("IntMin : "+IntMin);
  println("Renversement des axes : "+reverseXY);
  println("Mandelbrot(1) / Julia(0) : "+Mandel);
  println("Couleurs : "+couleurs);
}
