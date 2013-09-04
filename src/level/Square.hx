package level;
import motion.Actuate;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * ...
 * @author ...
 */
class Square extends Sprite
{

	public function new(size:Int) 
	{
		super();
		graphics.beginFill(0x4BbEeF);
		graphics.drawRoundRect(0, 0, size, size, size/20, size/20);
		graphics.endFill();
        buttonMode = true;
	}
	
	public function highlight(timeToHighlightInMilliseconds:Float):Void {
        Actuate.tween(this,timeToHighlightInMilliseconds/1000,{alpha:0}).onComplete(revokeHighlight,[timeToHighlightInMilliseconds]);
	}
	
	private function revokeHighlight(timeToHighlightInMilliseconds:Int):Void
	{
        Actuate.tween(this,timeToHighlightInMilliseconds/1000,{alpha:1});
	}
	
}