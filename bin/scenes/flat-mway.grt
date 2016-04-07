GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

DEFINE mass FLOAT 1 ;
DEFINE radius FLOAT 2 ;

TEXTURE board textures/milkyway.jpg ;
MATERIAL .plane EMIT white DIFFUSE board FILTER LINEAR ;
MATERIAL .black EMIT black ;

=SPHERE sph1 MATERIAL .black CENTER vec3.0 RADIUS radius ;
=TEX.PLANE boardPlane MATERIAL .plane ORIGIN VEC3 50 40 0 
	OXZDEGREES 90 OXYDEGREES 0
	UDIR VEC3 50 90 90
	VDIR VEC3 50 90 -90
	UV1 VEC2 1 1
	UV2 VEC2 0 0
	UVREPEAT 0
	;