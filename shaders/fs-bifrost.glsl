uniform float stepDepth;
uniform vec3 lightPos;

varying mat3 vINormMat;

varying vec3 vTang;
varying vec3 vNorm;
varying vec3 vBino;

varying vec2 vUv;

varying vec3 vEye;
varying vec3 vMPos;
varying vec3 vPos;

$hsv

#define STEPS 10
vec4 volumeColor( vec3 ro , vec3 rd , mat3 iBasis ){

  vec3 col = vec3( 0. );
  float lum = 0.;
  for( int i = 0; i < STEPS; i++ ){

    vec3 p = ro + rd * float( i ) * stepDepth;
    
    p = iBasis * p;
    lum += abs(sin( p.y * 40. ) +sin( p.z * 40. ) )/5.;
    col += hsv( p.x * 3. + lum / 20., 1. , 1. );

  } 

  return vec4( col , lum ) / float( STEPS );


}

void main(){

  vec3 col = vTang * .5 + .5;
  float alpha = 1.;

  vec3 lightDir = normalize( lightPos - vMPos );
  vec3 reflDir = reflect( lightDir , vNorm );
  
  float lightMatch = max( 0. , dot(-lightDir ,  vNorm ) );
  float reflMatch = max( 0. , dot(reflDir ,  vEye) );

  reflMatch = pow( reflMatch , 20. );

  vec4 volCol = volumeColor( vPos , normalize(vEye) , vINormMat );

  vec3 lambCol = lightMatch * volCol.xyz;
  vec3 reflCol = reflMatch * (vec3(1.) - volCol.xyz);


  col = lambCol + reflCol;

  vec3 eyeNorm = normalize( vEye ) * .5 + .5 ;
  gl_FragColor = vec4( volCol.xyz , 1. - volCol.w  );


  //gl_FragColor = vec4( normalize( vEye ) * .5 + .5 , 1. );
  //gl_FragColor = vec4( vTang , 1. ); 

}
