/**
 * Created by hlavko on 18.06.2014.
 */
package adapta.components.lights {

import adapta.components.Component;

import flash.geom.Vector3D;

public class DirectionalLight extends Component {

    private var _direction:Vector3D;

    public function get direction():Vector3D {
        return _direction;
    }

    public function set direction(value:Vector3D):void {
        _direction = value;
    }

    public function DirectionalLight() {
        super();
    }

    override public function init():void {
        super.init();

        _direction = new Vector3D();
    }
}

}
