package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class TitleScene extends Scene {
	private var mousePointer : gui.MousePointer;
	private var optionStart : gui.Option;
	private var optionQuit : gui.Option;
	private var titleText : gui.TextField;
	private var madeBy : gui.TextField;
	
	private var spawnTimer : Float = 0;
	
	public function new () : Void {
		super();
		
		mousePointer = new gui.MousePointer(0, 0);	
#if mobile
		titleText = new gui.TextField(HXP.width/2, HXP.height/2-40, "TOCHKA", 64, null, "top");
		madeBy = new gui.TextField(HXP.width/2, HXP.height/2+16, "BY DOMAGOJ STREKELJ", 16, null, "top");
		optionQuit = new gui.Option(HXP.width-12, 12, "QUIT", 48, "top-right");	
		optionStart = new gui.Option(HXP.width-12, HXP.height-12, "START", 48, "bottom-right");
#else
		titleText = new gui.TextField(HXP.width/2, HXP.height/2-32, "TOCHKA", 64, null, "bottom");
		madeBy = new gui.TextField(HXP.width/2, HXP.height/2-24, "BY DOMAGOJ STREKELJ", 16, null, "bottom");
		optionStart = new gui.Option(HXP.width/2, HXP.height/2+24, "START", 32, "top");
		optionQuit = new gui.Option(HXP.width/2, HXP.height/2+88, "QUIT", 32, "top");	
#end
		Input.define( "start", [Key.ENTER] );
		Input.define( "exit", [Key.ESCAPE, Key.BACKSPACE] );
	}
	
	override public function begin () : Void {
		add(mousePointer);
		
		add(titleText);
		add(madeBy);
		add(optionStart);
		add(optionQuit);
				
		super.begin();
	}
	
	override public function update () : Void {
		handleOptions();
		
		spawn();
		
		super.update();
	}
	
	override public function end () : Void {
		removeAll();
		
		super.end();
	}
	
	private function handleOptions () : Void {
#if	mobile
		if (mousePointer.handle(optionStart)) {
			HXP.scene = new scenes.GameScene();
		} else if (mousePointer.handle(optionQuit)) {
			flash.Lib.exit();
		}
#else
		if (mousePointer.handle(optionStart) || Input.pressed("start")) {
			HXP.scene = new scenes.GameScene();
		} else if (mousePointer.handle(optionQuit) || Input.pressed("exit")) {
			flash.Lib.exit();
		}
#end
	}
	
	private function spawn () : Void {
		spawnTimer += HXP.elapsed;
		if (spawnTimer >= 0.3) {
			add ( new entities.Obstacle ( HXP.width, (HXP.height-40) * HXP.random, HXP.random ) );
			spawnTimer=0;
		}
	}
}