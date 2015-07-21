module scene.scenemgr;

import math.vector;
import math.geometric;

interface ISceneObject
{
	@property Vectorf origin();
	@property Vectorf origin(Vectorf newOrig);
	@property AABB boundingbox();
}
