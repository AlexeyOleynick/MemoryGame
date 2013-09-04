package level;
import flash.filters.GlowFilter;
import flash.filters.BlurFilter;
import flash.events.Event;
import flash.errors.Error;
import motion.Actuate;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.display.Sprite;
import motion.easing.Expo;

class Message extends Sprite{

    private var textFormat:TextFormat;
    private var messageTextField:TextField;
    public function new(text:String = 'Message') {
        super();

        y = 0;
        alpha = 0;
        mouseEnabled = false;
        mouseChildren = false;

        messageTextField = new TextField();
        messageTextField.text = text;
        messageTextField.width = 300;
        messageTextField.selectable = false;

        textFormat = new TextFormat();
        textFormat.font = 'Arial';
        textFormat.color = 0xffffff;
        textFormat.size = 20;
        textFormat.align = TextFormatAlign.CENTER;

        messageTextField.setTextFormat(textFormat);

//        filters = [new GlowFilter(0x4BC9EF,1,20,40)];

        addChild(messageTextField);
        addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
    }

    private function addedToStageListener(event:Event):Void {
        x = stage.stageWidth / 2 - width / 2;
        run();
    }

    public function setSize(size:Int):Void {
        textFormat.size = size;
        messageTextField.setTextFormat(textFormat);
    }

    public function setText(text:String):Void {
        messageTextField.text = text;
        messageTextField.setTextFormat(textFormat);
    }

    private function run():Void {
        if(stage == null) throw new Error('To run animation message should be added to stage');
        Actuate.tween(this, 1, {y:stage.stageHeight / 2 - height / 2, alpha:1}).ease(Expo.easeOut).onComplete(messageShowedListener);
    }

    private function messageShowedListener():Void {
        Actuate.tween(this, 1, {y:stage.stageHeight / 2, alpha:0}).ease(Expo.easeIn).onComplete(messageRemovedListener);
    }

    private function messageRemovedListener():Void {
        dispatchEvent(new Event(Event.COMPLETE));
    }


}
