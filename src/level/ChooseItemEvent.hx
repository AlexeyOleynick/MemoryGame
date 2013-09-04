package level;
import flash.events.Event;
class ChooseItemEvent extends Event{

    public static inline var ITEM_CHOSEN:String = 'ITEM_CHOSEN';

    public var index:Int;

    public function new(index:Int) {
        super(ITEM_CHOSEN);
        this.index = index;
    }
}
