GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

DEFINE mass FLOAT 1.5 ;
DEFINE radius FLOAT 3 ;

DEFINE View1 VEC3 0 9 45 ;

MATERIAL .black EMIT black ;
MATERIAL .disc EMIT WAVE 500 ;

=SPHERE eh MATERIAL .black CENTER vec3.0 RADIUS radius ;
=ACCRETION acr MATERIAL .disc ORIGIN vec3.0 OXZDEGREES 90 OXYDEGREES 90 INNER 4.5 OUTER 12 ;
