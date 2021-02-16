class MoveSystem extends System {
	public override inline function update(tmod:Float) {
		for (e in Entity.ALL) {
			e.x += e.dx * tmod;
			e.y += e.dy * tmod;

			e.dx *= e.friction;
			e.dy *= e.friction;
		}
	}
}
