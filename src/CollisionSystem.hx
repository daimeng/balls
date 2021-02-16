class CollisionSystem extends System {
	public override inline function update(tmod:Float) {
		var elen = Entity.ALL.length;
		var a, b, rr, xdist, ydist;
		for (i in 0...elen) {
			a = Entity.ALL[i];
			for (j in i + 1...elen) {
				b = Entity.ALL[j];
				rr = a.r + b.r + 1;

				// AABB check
				if (Math.abs(a.x - b.x) < rr && Math.abs(a.y - b.y) < rr) {
					// Real distance check
					xdist = a.x - b.x;
					ydist = a.y - b.y;
					var dist = Math.sqrt(xdist * xdist + ydist * ydist);

					if (dist <= rr) {
						var ang = Math.atan2(b.y - a.y, b.x - a.x);
						var overlap = rr - dist;
						var xfa = Math.cos(ang);
						var yfa = Math.sin(ang);

						// adjust to not overlap
						a.x -= overlap * xfa;
						a.y -= overlap * yfa;
						b.x += overlap * xfa;
						b.y += overlap * yfa;

						a.dx -= Math.cos(ang) * M.fabs(a.dx + b.dx) * 0.5;
						a.dy -= Math.sin(ang) * M.fabs(a.dy + b.dy) * 0.5;
						b.dx += Math.cos(ang) * M.fabs(b.dx + a.dx) * 0.5;
						b.dy += Math.sin(ang) * M.fabs(b.dy + a.dy) * 0.5;
					}
				}
			}
		}
	}
}
