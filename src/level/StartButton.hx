package level;
import flash.events.Event;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.display.Sprite;
class StartButton extends Sprite{
    public function new() {
        super();
        buttonMode = true;

        var startText:TextField = new TextField();
        startText.text = 'START';
        startText.textColor = 0xffffff;
        startText.width = startText.textWidth+30;
        startText.y = 15;
        startText.height = 35;
        startText.selectable = false;
        startText.mouseEnabled = false;

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = TextFormatAlign.CENTER;
        textFormat.font = 'Arial';
        textFormat.bold = true;

        startText.setTextFormat(textFormat);
        addChild(startText);

        graphics.beginFill(0xee44aa);
        graphics.drawRoundRect(0,0, startText.width, 50, 100/10, 100/10);

        addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
    }


    private function addedToStageListener(event:Event):Void {
        x = stage.stageWidth/2- width/2;
        y = stage.stageHeight/2- height/2;
    }
}
