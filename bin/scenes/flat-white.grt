GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

MATERIAL .plane EMIT white FILTER LINEAR ;

=TEX.PLANE boardPlane MATERIAL .plane ORIGIN VEC3 0 0 200 
	OXZDEGREES 0 OXYDEGREES 0
	UDIR VEC3 50 90 90
	VDIR VEC3 50 90 -90
	UV1 VEC2 1 1
	UV2 VEC2 0 0
	UVREPEAT 0
	;
