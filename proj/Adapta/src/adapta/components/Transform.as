package adapta.components {

import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;

/**
 * Transform
 * TODO - docs
 *
 * @author hlavko
 */
public class Transform extends Component {

    private var _pivot:Vector3D;

    public function get pivot():Vector3D {
        return _pivot;
    }

    private var _position:Vector3D;

    public function get position():Vector3D {
        return _position;
    }

    private var _rotation:Vector3D;

    public function get rotation():Vector3D {
        return _rotation;
    }

    private var _scale:Vector3D;

    public function get scale():Vector3D {
        return _scale;
    }

    public function Transform() {
        _pivot = new Vector3D();
        _position = new Vector3D();
        _scale = new Vector3D(1.0, 1.0, 1.0);
        _rotation = new Vector3D();
    }

    override public function dispose():void {
        _position = null;
    }


}

}
