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
						// a.x = a.xx;
						// a.y = a.yy;
						// b.x = b.xx;
						// b.y = b.yy;

						var na0 = Math.atan2(b.y - a.y, b.x - a.x);
						var dira0 = Math.atan2(a.dy, a.dx);
						var nb0 = Math.atan2(a.y - b.y, a.x - b.x);
						var dirb0 = Math.atan2(b.dy, b.dx);
						var speeda = Math.sqrt(a.dy * a.dy + a.dx * a.dx);
						var speedb = Math.sqrt(b.dy * b.dy + b.dx * b.dx);

						var cosa = Math.cos(dira0 - na0);
						var sina = Math.sin(dira0 - na0);
						var cosb = Math.cos(dirb0 - nb0);
						var sinb = Math.sin(dirb0 - nb0);

						var norma = cosa * speeda;
						var perpa = sina * speeda;
						var normb = cosb * speedb;
						var perpb = sinb * speedb;

						var normfa = normb;
						var normfb = norma;

						a.dx = Math.cos(nb0) * normfa + Math.sin(na0) * perpa;
						a.dy = Math.sin(nb0) * normfa + Math.cos(na0) * perpa;
						b.dx = Math.cos(na0) * normfb + Math.sin(nb0) * perpb;
						b.dy = Math.sin(na0) * normfb + Math.cos(nb0) * perpb;

						// FIXME: Do not push back on normal!
						// Readjust based on direction
						var overlap = rr - dist;
						var nx = Math.cos(na0);
						var ny = Math.sin(na0);

						// adjust to not overlap
						a.x -= overlap * nx;
						a.y -= overlap * ny;
						b.x += overlap * nx;
						b.y += overlap * ny;

						// a.dx -= nx * M.fabs(a.dx + b.dx) * 0.5;
						// a.dy -= ny * M.fabs(a.dy + b.dy) * 0.5;
						// b.dx += nx * M.fabs(b.dx + a.dx) * 0.5;
						// b.dy += ny * M.fabs(b.dy + a.dy) * 0.5;
					}
				}
			}
		}
	}
}
