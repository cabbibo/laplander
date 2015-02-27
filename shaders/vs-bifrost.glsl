
attribute vec3 tangent;

// TODO: can we compute this in cpu?
varying mat3 vINormMat;

varying vec3 vTang;
varying vec3 vNorm;
varying vec3 vBino;
varying vec2 vUv;

varying vec3 vEye;
varying vec3 vMPos;

$matInverse

void main(){

  vec3 pos = position;
  vUv = uv;
  

  vNorm = normal;
  vTang = tangent;
  
  //vNorm = normalMatrix * normal;
  //vTang = normalMatrix * tangent;

  vBino = cross( vNorm , vTang );

  mat3 normMat = mat3(
    vNorm.x , vNorm.y , vNorm.z ,
    vTang.x , vTang.y , vTang.z ,
    vBino.x , vBino.y , vBino.z 
  );

  //normMat = normalMatrix * normMat;
  vINormMat = matInverse( normMat );

  vMPos = ( modelMatrix * vec4( pos , 1. ) ).xyz;
  vEye = normalize( cameraPosition - vMPos );

  gl_Position = projectionMatrix * modelViewMatrix * vec4( pos , 1. );

}
