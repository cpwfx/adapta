/**
 * Created by hlavko on 16.06.2014.
 */
package examples.SimpleMouseBrightness.component {

import adapta.components.Component;
import adapta.core.Adapta;
import adapta.core.Input;
import adapta.components.cameras.Camera;

import com.adobe.utils.PerspectiveMatrix3D;

import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.ui.Keyboard;

public class SimpleCameraController extends Component {

    private const MAX_FORWARD_VELOCITY:Number = 0.5;
    private const MAX_ROTATION_VELOCITY:Number = 2.5;
    private const LINEAR_ACCELERATION:Number = /*0.0005;*/ 0.001;
    private const ROTATION_ACCELERATION:Number = /*0.01;*/ 0.05;
    private const DAMPING:Number = 1.09;

    private var _cameraLinearAcceleration:Number = 0;
    private var _cameraRotationAcceleration:Number = 0;
    private var _cameraLinearVelocity:Vector3D;
    private var _cameraRotationVelocity:Number = 0;

    private var _worldTransform:Matrix3D;

    private var _camera:Camera;

    public function SimpleCameraController() {
    }

    override public function init():void {
        super.init();
    }

    override public function start():void {
        super.start();

        _camera = Camera(entity);

        _cameraLinearVelocity = new Vector3D();
        _worldTransform = new Matrix3D();
        _worldTransform.appendTranslation(0, 0, 5);

        _camera.projectionMatrix = new PerspectiveMatrix3D();
        _camera.projectionMatrix.identity();
        _camera.projectionMatrix.perspectiveFieldOfViewRH(45.0, Adapta.main.stage.stageWidth / Adapta.main.stage.stageHeight, 0.01, 100.0);

        _camera.viewMatrix = new Matrix3D();
        _camera.viewMatrix.identity();
    }

    override public function update():void {
        super.update();

        if (Input.testKey(Keyboard.W))
            _cameraLinearAcceleration = -LINEAR_ACCELERATION;
        else if (Input.testKey(Keyboard.S))
            _cameraLinearAcceleration = LINEAR_ACCELERATION;
        else
            _cameraLinearAcceleration = 0;

        if (Input.testKey(Keyboard.A))
            _cameraRotationAcceleration = ROTATION_ACCELERATION;
        else if (Input.testKey(Keyboard.D))
            _cameraRotationAcceleration = -ROTATION_ACCELERATION;
        else
            _cameraRotationAcceleration = 0;

        _cameraLinearVelocity.z = calculateUpdatedVelocity(_cameraLinearVelocity.z, _cameraLinearAcceleration, MAX_FORWARD_VELOCITY);
        _cameraRotationVelocity = calculateUpdatedVelocity(_cameraRotationVelocity, _cameraRotationAcceleration, MAX_ROTATION_VELOCITY);

        _worldTransform.appendRotation(_cameraRotationVelocity, Vector3D.Y_AXIS, _worldTransform.position);
        _worldTransform.position = _worldTransform.transformVector(_cameraLinearVelocity);

        _camera.viewMatrix.copyFrom(_worldTransform);
        _camera.viewMatrix.invert();
    }

    protected function calculateUpdatedVelocity(curVelocity:Number, curAcceleration:Number, maxVelocity:Number):Number {
        var newVelocity:Number;

        if (curAcceleration != 0) {
            newVelocity = curVelocity + curAcceleration;
            if (newVelocity > maxVelocity) {
                newVelocity = maxVelocity;
            }
            else if (newVelocity < -maxVelocity) {
                newVelocity = -maxVelocity;
            }
        }
        else {
            newVelocity = curVelocity / DAMPING;
        }
        return newVelocity;
    }

    override public function dispose():void {
        super.dispose();
    }

}

}
