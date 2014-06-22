/**
 * Created by hlavko on 28.05.2014.
 */
package examples.HelloStage3D {

import adapta.entities.Entity;
import adapta.geometry.MeshPool;

import examples.HelloStage3D.Quad;
import adapta.material.TextureUtils;

public class Image2 extends Entity {

    private var _speed:Number;

    public function Image2() {
    }

    override public function init():void {
        addFromInstance(MeshPool.acquire("quad")) as Quad;
        addFromInstance(new TextureUtils(new ColorShader()));

        _speed = 2;
    }

    override public function start():void {
        super.start();

        transform.position.x = 2;
        transform.position.y = 2;
    }

    override public function update():void {
        super.update();
    }

    override public function dispose():void {
        super.dispose();

        _speed = null;
    }

}

}
