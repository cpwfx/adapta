/**
 * Created by hlavko on 18.06.2014.
 */
package examples.LightingScene.entity {

import adapta.components.cameras.FreeLookCamera3D;
import adapta.components.lights.DirectionalLight;
import adapta.core.Input;
import adapta.entities.Entity;

import flash.ui.Keyboard;

public class Character extends Entity {

    private var _light:DirectionalLight;
    private var _camera:FreeLookCamera3D;

    private var _fixedLight:Boolean = true;
    private var _isDown:Boolean = true;

    public function Character() {
        super();
    }

    override public function init():void {
    }

    override public function start():void {
        super.start();

        _light = getComponent(DirectionalLight) as DirectionalLight;
        _light.direction.setTo(0, -1, -1);
        _light.direction.normalize();

        _camera = getComponent(FreeLookCamera3D) as FreeLookCamera3D;
    }

    override public function update():void {
        super.update();

        if (Input.testKey(Keyboard.SPACE)){
            if (!_isDown){
                _fixedLight = !_fixedLight;
            }

            _isDown = true;
        }
        else
            _isDown = false;

        if (!_fixedLight)
            _light.direction.setTo(_camera.direction.x, _camera.direction.y, _camera.direction.z);
            _light.direction.normalize();
    }

    override public function dispose():void {
        super.dispose();
    }


}

}
