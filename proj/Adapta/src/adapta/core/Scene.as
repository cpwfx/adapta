/**
 * Created by hlavko on 28.05.2014.
 */
package adapta.core {

import adapta.components.cameras.Camera;
import adapta.components.lights.DirectionalLight;

public class Scene {

    protected var _camera:Camera;

    public function get camera():Camera {
        return _camera;
    }

    public function set camera(value:Camera):void {
        _camera = value;
    }

    protected var _light:DirectionalLight;

    public function get light():DirectionalLight {
        return _light;
    }

    public function set light(value:DirectionalLight):void {
        _light = value;
    }

    public function Scene() {
    }

    public function start():void {

    }


}

}
