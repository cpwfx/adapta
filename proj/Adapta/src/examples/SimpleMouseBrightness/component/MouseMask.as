/**
 * Created by hlavko on 03.06.2014.
 */
package examples.SimpleMouseBrightness.component {

import adapta.components.Component;
import adapta.core.Adapta;

public class MouseMask extends Component {

    public var intensity:Number;

    public function MouseMask() {
        super();
    }

    override public function init():void {
    }

    override public function start():void {
    }

    override public function update():void {
        intensity = Adapta.main.stage.mouseY / Adapta.main.stage.stageHeight;
    }

    override public function dispose():void {
    }
}

}
