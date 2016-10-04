GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

DEFINE skyDist FLOAT 1000000 ;
DEFINE negskyDist FLOAT -1000000 ;
DEFINE cameraOrigin VEC3 0 0 0 ;
DEFINE cameraAngles VEC3 0 0 180 ;

TEXTURE up textures/MWCubeBox/up.png ;
TEXTURE down textures/MWCubeBox/down.png ;

TEXTURE front textures/MWCubeBox/front.png ;
TEXTURE back textures/MWCubeBox/back.png ;

TEXTURE left textures/MWCubeBox/left.png ;
TEXTURE right textures/MWCubeBox/right.png ;

MATERIAL .up EMIT white DIFFUSE up FILTER LINEAR ;
MATERIAL .down EMIT white DIFFUSE down FILTER LINEAR ;

MATERIAL .front EMIT white DIFFUSE front FILTER LINEAR ;
MATERIAL .back EMIT white DIFFUSE back FILTER LINEAR ;

MATERIAL .left EMIT white DIFFUSE left FILTER LINEAR ;
MATERIAL .right EMIT white DIFFUSE right FILTER LINEAR ;

#podloga
=TEX.TRIANGLE .down1 MATERIAL .down POINT1 VEC3 skyDist negskyDist skyDist POINT2 VEC3 skyDist negskyDist negskyDist POINT3 VEC3 negskyDist negskyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV1 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .down2 MATERIAL .down POINT1 VEC3 skyDist negskyDist skyDist POINT2 VEC3 negskyDist negskyDist skyDist POINT3 VEC3 negskyDist negskyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV1 VEC2 1.0 1.0 ;
#sufit
=TEX.TRIANGLE .up1 MATERIAL .up POINT1 VEC3 negskyDist skyDist skyDist POINT2 VEC3 negskyDist skyDist negskyDist POINT3 VEC3 skyDist skyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV1 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .up2 MATERIAL .up POINT1 VEC3 negskyDist skyDist skyDist POINT2 VEC3 skyDist skyDist skyDist POINT3 VEC3 skyDist skyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV1 VEC2 1.0 1.0 ;
#tyl
=TEX.TRIANGLE .back1 MATERIAL .back POINT1 VEC3 skyDist skyDist skyDist POINT2 VEC3 negskyDist skyDist skyDist POINT3 VEC3 negskyDist negskyDist skyDist UV1 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV3 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .back2 MATERIAL .back POINT1 VEC3 skyDist skyDist skyDist POINT2 VEC3 skyDist negskyDist skyDist POINT3 VEC3 negskyDist negskyDist skyDist UV1 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV3 VEC2 1.0 1.0 ;
#przod
=TEX.TRIANGLE .front1 MATERIAL .front POINT1 VEC3 skyDist negskyDist negskyDist POINT2 VEC3 negskyDist negskyDist negskyDist POINT3 VEC3 negskyDist skyDist negskyDist UV1 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV3 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .front2 MATERIAL .front POINT1 VEC3 skyDist negskyDist negskyDist POINT2 VEC3 skyDist skyDist negskyDist POINT3 VEC3 negskyDist skyDist negskyDist UV1 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV3 VEC2 1.0 1.0 ;
#lewo
=TEX.TRIANGLE .left1 MATERIAL .left POINT1 VEC3 negskyDist skyDist negskyDist POINT2 VEC3 negskyDist skyDist skyDist POINT3 VEC3 negskyDist negskyDist skyDist UV1 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV3 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .left2 MATERIAL .left POINT1 VEC3 negskyDist skyDist negskyDist POINT2 VEC3 negskyDist negskyDist negskyDist POINT3 VEC3 negskyDist negskyDist skyDist UV1 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV3 VEC2 1.0 1.0 ;
#prawo
=TEX.TRIANGLE .right1 MATERIAL .right POINT1 VEC3 skyDist skyDist skyDist POINT2 VEC3 skyDist skyDist negskyDist POINT3 VEC3 skyDist negskyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 1.0 0.0 UV1 VEC2 1.0 1.0 ;
=TEX.TRIANGLE .right2 MATERIAL .right POINT1 VEC3 skyDist skyDist skyDist POINT2 VEC3 skyDist negskyDist skyDist POINT3 VEC3 skyDist negskyDist negskyDist UV3 VEC2 0.0 0.0 UV2 VEC2 0.0 1.0 UV1 VEC2 1.0 1.0 ;