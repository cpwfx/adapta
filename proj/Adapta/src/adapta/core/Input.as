/**
 * Created by hlavko on 16.06.2014.
 */
package adapta.core {

import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class Input {

    static private var _dictionary:Dictionary;
    static private var _main:Sprite;

    static public function start(main:Sprite):void {
        _dictionary = new Dictionary();
        _main = main;

        _main.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
        _main.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
    }

    static protected function onKeyDownHandler(event:KeyboardEvent):void {
        _dictionary[event.keyCode] = true;
    }

    static protected function onKeyUpHandler(event:KeyboardEvent):void {
        _dictionary[event.keyCode] = false;
    }

    static public function testKey(keyCode:int):Boolean {
        if (!(keyCode in _dictionary))
            return false;

        return _dictionary[keyCode];
    }

}

}
