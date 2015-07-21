module scene.scenemgr;

import config;
import math.vector;
import math.geometric;

interface ISceneObject
{
	@property Vectorf origin() const;
	@property Vectorf origin(Vectorf newOrig);
	@property AABB boundingbox() const;
}

interface IWorldSpace
{
	fpnum Distance(Point A, Point B);
}
