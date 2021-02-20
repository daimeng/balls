class Entity {
	public static var ALL:Array<Entity> = [];

	public var x:Float;
	public var y:Float;
	public var xx:Float;
	public var yy:Float;
	public var r:Float;
	public var dx = 0.;
	public var dy = 0.;
	public var friction = 0.96;
	public var spr:h2d.Drawable;
	public var col:h2d.col.Circle;
	public var intx:h2d.Interactive;
	public var line:h2d.Graphics;

	var dragging = false;

	public function new(x, y, r) {
		ALL.push(this);

		this.x = x;
		this.y = y;
		this.xx = x;
		this.yy = y;
		this.r = r;

		var g = new h2d.Graphics(Main.inst.s2d);
		g.beginFill(0xFFFFFF);
		g.drawCircle(0, 0, r, 16);
		g.endFill();
		spr = g;

		col = new h2d.col.Circle(x, y, r * 1.2);
		intx = new h2d.Interactive(128, 128, Main.inst.s2d, col);
		line = Main.inst.line;

		intx.onPush = handleClick;
		intx.onRelease = stopDrag;
	}

	public function handleClick(event:hxd.Event) {
		intx.startCapture(startDrag);
		line.visible = true;
		line.x = this.x;
		line.y = this.y;
		dragging = true;
	}

	public function startDrag(event:hxd.Event) {
		if (event.kind == EMove) {
			var ydist = event.relY - line.y;
			var xdist = event.relX - line.x;
			line.rotation = Math.atan2(ydist, xdist);
			line.scaleX = Math.sqrt(ydist * ydist + xdist * xdist);
		}
	}

	public function stopDrag(event:hxd.Event) {
		intx.stopCapture();
		line.visible = false;
		line.scaleX = 0;
		dx = (line.x - event.relX) / 10;
		dy = (line.y - event.relY) / 10;
		dragging = false;
	}

	public function preUpdate(tmod:Float) {}

	public function postUpdate(tmod:Float) {
		spr.x = (x + xx) / 2;
		spr.y = (y + yy) / 2;
		col.x = x;
		col.y = y;
		if (dragging) {
			line.x = x;
			line.y = y;
		}
		xx = x;
		yy = y;
	}
}
