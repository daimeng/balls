class BorderSystem extends System {
	public override inline function update(tmod:Float) {
		for (e in Entity.ALL) {
			if (e.y > 720) {
				e.y = 720;
				e.dy = -e.dy;
			} else if (e.y < 0) {
				e.y = 0;
				e.dy = -e.dy;
			}

			if (e.x > 1280) {
				e.x = 1280;
				e.dx = -e.dx;
			} else if (e.x < 0) {
				e.x = 0;
				e.dx = -e.dx;
			}
		}
	}
}
