package level;
import flash.geom.Rectangle;
import org.casalib.util.AlignUtil;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.Lib;
/**
 * ...
 * @author ...
 */
class Level
{
    private var view:LevelView;
    private var sequence:Array<Int>;
    private var sequenceIterator:Iterator<Int>;
    private var levelNumber:Int;

    public function new()
	{
		view = new LevelView();
        levelNumber = 1;
        view.setShouldInteract(false);
		Lib.current.addChild(view);
        var rect:Rectangle  =  new Rectangle(0,0,Lib.current.stage.stageWidth,Lib.current.stage.stageHeight);
        AlignUtil.alignMiddleCenter(view,rect);
        view.start();
        view.addEventListener(LevelView.CREATION_COMPLETE, levelCreatedListener);
	}

    private function levelCreatedListener(e:Event):Void {
        view.removeEventListener(LevelView.CREATION_COMPLETE, levelCreatedListener);

        var button = new StartButton();
        Lib.current.addChild(button);
        button.addEventListener(MouseEvent.CLICK, startButtonClickedListener);
    }

    public function startButtonClickedListener(event:MouseEvent):Void {

        var levelMessage:Message = new Message('Level '+levelNumber);
        levelMessage.setSize(30);
        levelMessage.addEventListener(Event.COMPLETE, levelMessageShowedListener);
        Lib.current.addChild(levelMessage);

        cast(event.target, StartButton).removeEventListener(MouseEvent.CLICK, startButtonClickedListener);
        Lib.current.removeChild(cast(event.target, StartButton));

    }

    private function levelMessageShowedListener(e:Event):Void {
        cast(e.target, Message).removeEventListener(Event.COMPLETE, levelMessageShowedListener);
        sequence = generateSequence(3,levelNumber);
        sequenceIterator = sequence.iterator();
        view.highlightSequence(sequence);
        view.addEventListener(LevelView.PLAYBACK_COMPLETE, playbackCompleteListener);
    }

    private function playbackCompleteListener(e:Event):Void {
        view.setShouldInteract(true);
        view.addEventListener(ChooseItemEvent.ITEM_CHOSEN, itemChosenListener);
    }

    public function itemChosenListener(event:ChooseItemEvent):Void {
        var statusMessage:Message = new Message();
        if(sequenceIterator.next() == event.index){
            if(!sequenceIterator.hasNext()){
                view.setShouldInteract(false);
                statusMessage.setText('Victory');
                statusMessage.setSize(30);
                statusMessage.addEventListener(Event.COMPLETE, nextLevel);
            }else{
                statusMessage.setText('Good');
            }
        }else{
            view.setShouldInteract(false);
            statusMessage.setText('Defeat');
            statusMessage.setSize(30);
            statusMessage.addEventListener(Event.COMPLETE, restart);
        }


        Lib.current.addChild(statusMessage);
    }

    private function restart(e:Event):Void {
        levelNumber = 1;
        levelCreatedListener(null);
    }

    private function nextLevel(e:Event):Void {
        levelNumber++;
        levelCreatedListener(null);
    }
	
	function generateSequence(maxNumber:Int, count:Int):Array<Int> 
	{
		var sequence:Array<Int> = new Array<Int>();
		for(i in 0...count){
			var randomInt:Int = Math.floor(Math.random() * (maxNumber + 1));
			sequence.push(randomInt);
		}
		return sequence;
	}
	
}