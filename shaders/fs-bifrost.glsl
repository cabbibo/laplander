uniform float stepDepth;

varying mat3 vINormMat;

varying vec3 vTang;
varying vec3 vNorm;
varying vec3 vBino;

varying vec2 vUv;

varying vec3 vEye;
varying vec3 vMPos;

$hsv

#define STEPS 10
vec4 volumeColor( vec3 ro , vec3 rd , mat3 iBasis ){

  vec3 col = vec3( 0. );
  float lum = 0.;
  for( int i = 0; i < STEPS; i++ ){

    vec3 p = ro + rd * float( i ) * stepDepth;
    
    p = iBasis * p;
    lum += abs(sin( p.y * 40. ) +sin( p.z * 40. ) )/5.;
    col += hsv( p.x * 2. + lum / 10., 1. , 1. );

  } 

  return vec4( col , lum ) / float( STEPS );


}

void main(){

  vec3 col = vTang * .5 + .5;
  float alpha = 1.;

  vec4 volCol = volumeColor( vMPos , vEye , vINormMat );

  gl_FragColor = vec4( volCol.xyz , 1. - volCol.w  ); 

}
