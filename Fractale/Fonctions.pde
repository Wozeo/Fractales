


float sh(float x) {
  return 0.5*(exp(x)-exp(-x));
}

float ch(float x) {
  return 0.5*(exp(x)+exp(-x));
}

float cosCpl(boolean reel,float r,float i){
  if(reel){
    return cos(r)*ch(i);
  }else{
    return -sin(r)*sh(i);
  }
}

float sinCpl(boolean reel,float r,float i){
  if(reel){
    return sin(r)*ch(i);
  }else{
    return cos(r)*sh(i);
  }
}

float invCpl(boolean reel,float r,float i){
  float nt = r*r+i*i;
  if(reel){
    return r/nt;
  }else{
    return -i/nt;
  }
}

float shCpl(boolean reel,float r,float i){
  if(reel){
    return sh(r)*cos(i);
  }else{
    return ch(r)*sin(i);
  }
}

float chCpl(boolean reel,float r,float i){
  if(reel){
    return ch(r)*cos(i);
  }else{
    return sh(r)*sin(i);
  }
}

float factorielle(int k){
  if(k <= 1){
    return 1;
  }else{
    float r = 1;
    for(int i = 1; i <= k; i ++){
      r *= i;
    }
    return r;
  }
}


float pcR(boolean reel, float r, float i, float rs, float is, float p) {
  if (p == 1) {
    if (reel) {
      return r;
    } else {
      return i;
    }
  } else if (p <= 0) {
    return 1;
  } else {
    return pcR(reel, r*rs-i*is, r*is+rs*i, rs, is, p-1);
  }
}
