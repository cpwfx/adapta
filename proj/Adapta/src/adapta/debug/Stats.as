/**
 * Created by hlavko on 02.06.2014.
 */
package adapta.debug {

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getTimer;

public class Stats extends Sprite {

    private var _fpsLast:uint;
    private var _fpsTicks:uint;
    private var _fpsTf:TextField;

    public function Stats() {
        init();
    }

    private function init():void{
        // init timer
        _fpsLast = getTimer();

        // a text format descriptor used by all gui labels
        var myFormat:TextFormat = new TextFormat();
        myFormat.color = 0xFFFFFF;
        myFormat.size = 13;

        // create an FPSCounter that displays the framerate on screen
        _fpsTf = new TextField();
        _fpsTf.x = 0;
        _fpsTf.y = 0;
        _fpsTf.selectable = false;
        _fpsTf.autoSize = TextFieldAutoSize.LEFT;
        _fpsTf.defaultTextFormat = myFormat;
        _fpsTf.text = "Initializing Stage3d...";
        addChild(_fpsTf);
    }

    public function update():void{
        _fpsTicks++;

        var now:uint = getTimer();
        var delta:uint = now - _fpsLast;

        if (delta >= 1000){
            var fps:Number = _fpsTicks / delta * 1000;
            _fpsTf.text = fps.toFixed(1) + " fps";
            _fpsTicks = 0;
            _fpsLast = now;
        }

    }

}

}
