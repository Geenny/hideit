package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			
			return;
			
			var value:Number = 0.000001052; // 0.01 TH
			var price:Number = 0.00001285 / 19;
			
			var a:Number = 0.1; // = 1.558 22$
			var b:Number = 0;
			var power:Number = 1.2;
			
			for (var j:int = 10; j < 280; j++) {
				
				b = 0;
				power = 0.1;
				
				for (var i:int = 0; i < 360; i++) {
					
					b += power * 1.558;
					
					while (i < j && b > 2.2) {
						b -= 2.2;
						power += 0.01;
					}
					
					
				}
				
				trace(j, b, power);
				
			}
			
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}