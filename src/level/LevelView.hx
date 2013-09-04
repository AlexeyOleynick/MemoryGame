package level;

import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.events.Event;
import flash.geom.Point;
import motion.Actuate;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;
import flash.utils.SetIntervalTimer;
import flash.Vector;
/**
 * ...
 * @author ...
 */
class LevelView extends Sprite {
    static inline var SQUARE_SIZE:Int = 200;
    static inline var SQUARE_MARGIN:Int = 15;
    public static inline var CREATION_COMPLETE:String = 'CREATION_COMPLETE';
    public static inline var PLAYBACK_COMPLETE:String = 'PLAYBACK_COMPLETE';
    private var squares:Vector<Square>;

    public function new() {
        super();
        squares = new Vector<Square>();
        createSquares(2, 2);
    }

    public function setShouldInteract(value:Bool):Void {
        mouseEnabled = value;
        mouseChildren = value;
    }

    public function getSquareCount():Int {
        return squares.length;
    }

    public function highlightSequence(sequence:Array<Int>):Void {
        var sequenceSquareHighlighter:SequenceSquareHighlighter = new SequenceSquareHighlighter(squares, sequence, 500);
        sequenceSquareHighlighter.addEventListener(Event.COMPLETE, highlightingCompleteListener);
    }

    public function highlightingCompleteListener(event:Event):Void {
        var startPlayerMessage:Message = new Message('Repeat\nplease');
        startPlayerMessage.addEventListener(Event.COMPLETE, messageRemovedListener);
        Lib.current.addChild(startPlayerMessage);
    }

    private function messageRemovedListener(e:Event):Void {
        dispatchEvent(new Event(PLAYBACK_COMPLETE));
    }

    private function createSquares(rows:Int, cols:Int):Void {
        for (row in 0...rows) {
            for (col in 0...cols) {
                var square:Square = createSquare(row, col);
                squares.push(square);
                square.addEventListener(MouseEvent.CLICK, squareClickListener);
                addSquareToStage(square);
            }
        }
    }

    public function addSquareToStage(square:Square):Void {
        addChild(square);
    }

    public function start():Void {
        for(square in squares){
            var targetX:Float = square.x;
            var targetY:Float = square.y;

            square.x = Math.random() * (300 + 800) - 300 - 200;
            square.y = Math.random() * (300 + 800) - 300 - 200;

            Actuate.tween(square, 1, {x:targetX, y:targetY});
        }
        var creationTimer:Timer = new Timer(1500, 1);
        creationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, creationTimerCompleteListener);
        creationTimer.start();
    }

    private function creationTimerCompleteListener(event:TimerEvent):Void {
        cast(event.target, Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, creationTimerCompleteListener);
        dispatchEvent(new Event(LevelView.CREATION_COMPLETE));
    }


    private function squareClickListener(e:MouseEvent):Void {
        dispatchEvent(new ChooseItemEvent(squares.indexOf(cast(e.target, Square))));
        cast(e.target, Square).highlight(200);
    }

    function createSquare(row, col):Square {
        var square:Square = new Square(SQUARE_SIZE);
        square.x = col * SQUARE_SIZE + col * SQUARE_MARGIN;
        square.y = row * SQUARE_SIZE + row * SQUARE_MARGIN;
        return square;
    }

}