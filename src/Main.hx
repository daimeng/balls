class Main extends hxd.App {
	var tmod:Float;
	var systems:Array<System>;

	public var line:h2d.Graphics;

	override function init() {
		s2d.scaleMode = LetterBox(1280, 720);

		line = new h2d.Graphics(s2d);
		line.beginFill(0xFFFFFFFF);
		line.drawRect(-0.1, -0.5, 1.1, 1);
		line.scaleX = 0;
		line.endFill();
		line.visible = false;

		new Entity(100, 200, 8);
		new Entity(70, 180, 8);
		new Entity(200, 100, 8);

		systems = [new BorderSystem(), new CollisionSystem(), new MoveSystem()];
	}

	override function update(dt:Float) {
		super.update(dt);
		tmod = hxd.Timer.tmod;

		for (sys in systems) {
			sys.update(tmod);
		}

		for (e in Entity.ALL) {
			e.postUpdate(tmod);
		}
	}

	public static var inst:Main;

	static function main() {
		inst = new Main();
	}
}
