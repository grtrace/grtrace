module scene.scenemgr;

import math.vector;

interface ISceneObject
{
	@property Vectorf origin();
	@property Vectorf origin(Vectorf newOrig);
	@property AABB boundingbox();
}
