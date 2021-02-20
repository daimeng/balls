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
						a.x = (a.xx + a.x) / 2;
						a.y = (a.yy + a.y) / 2;
						b.x = (b.xx + b.x) / 2;
						b.y = (b.yy + b.y) / 2;

						var dira0 = Math.atan2(a.dy, a.dx);
						var dirb0 = Math.atan2(b.dy, b.dx);
						var norm0 = Math.atan2(b.y - a.y, b.x - a.x);
						var vai = Math.sqrt(a.dy * a.dy + a.dx * a.dx);
						var vbi = Math.sqrt(b.dy * b.dy + b.dx * b.dx);

						var cosa = Math.cos(dira0 - norm0);
						var cosb = Math.cos(dirb0 - norm0);
						var sina = Math.sin(dira0 - norm0);
						var sinb = Math.sin(dirb0 - norm0);
						var cosn = Math.cos(norm0);
						var sinn = Math.sin(norm0);
						var cosp = Math.cos(norm0 + Math.PI * 0.5);
						var sinp = Math.sin(norm0 + Math.PI * 0.5);

						var norma = cosa * vai;
						var perpa = sina * vai;
						var normb = cosb * vbi;
						var perpb = sinb * vbi;

						a.dx = normb * cosn + perpa * cosp;
						a.dy = normb * sinn + perpa * sinp;
						b.dx = norma * cosn + perpb * cosp;
						b.dy = norma * sinn + perpb * sinp;
					}
				}
			}
		}
	}
}
