/**
 * Created by hlavko on 26.05.2014.
 */
package examples.HelloStage3D {

import adapta.core.Adapta;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

[SWF(pageTitle="HelloExample", backgroundColor="#222222", width="800", height="600", frameRate="60")]
public class HelloExample extends Sprite {

    public function HelloExample():void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        // entry point
        Adapta.start(this, ImageScene, true);
    }

}

}
