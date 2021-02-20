package test;

class TestAll {
	public static function main() {
		// the long way
		// var runner = new Runner();
		// Report.create(runner);
		// runner.run();

		// the short way in case you don't need to handle any specifics
		utest.UTest.run([new TestCollisionSystem()]);
	}
}
