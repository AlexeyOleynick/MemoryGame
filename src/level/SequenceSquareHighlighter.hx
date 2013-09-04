package level;
import flash.events.EventDispatcher;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.Vector;

/**
 * ...
 * @author ...
 */
class SequenceSquareHighlighter extends EventDispatcher
{
	
	private var squares:Vector<Square>;
	private var sequence:Array<Int>;

	private var sequenceIterator:Iterator<Int>;
	private var timeToHighlightInMs:Int;
	
	public function new(squares:Vector<Square>, sequence:Array<Int>, timeToHighlightInMs:Int) 
	{
        super();
		this.squares = squares;
		this.sequenceIterator = sequence.iterator();
		this.timeToHighlightInMs = timeToHighlightInMs;
		highlightNext();
	}
	
	private function highlightNext():Void {
		if (!sequenceIterator.hasNext()){
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }
		squares[sequenceIterator.next()].highlight(timeToHighlightInMs);
		var timer:Timer = new Timer(timeToHighlightInMs+timeToHighlightInMs/3, 1);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);
		timer.start();
	}	
	
	private function timerCompleteListener(e:Event):Void 
	{
		cast(e.currentTarget, Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);
		highlightNext();
	}
	
}