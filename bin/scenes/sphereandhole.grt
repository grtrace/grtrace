GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

DEFINE mass FLOAT 1.5 ;
DEFINE radius FLOAT 3 ;

MATERIAL .black EMIT black ;
MATERIAL .white EMIT white ;

=SPHERE eh MATERIAL .black CENTER vec3.0 RADIUS radius ;
=SPHERE sph MATERIAL .white CENTER VEC3 0 0 10 RADIUS 5 ;
