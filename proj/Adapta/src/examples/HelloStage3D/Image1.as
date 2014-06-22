/**
 * Created by hlavko on 28.05.2014.
 */
package examples.HelloStage3D {

import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.TexturePool;

import examples.HelloStage3D.Quad;
import adapta.material.TextureUtils;

import flash.display3D.textures.Texture;

public class Image1 extends Entity {

    private var _speed:Number;

    public function Image1() {
    }

    override public function init():void {
        addFromInstance(MeshPool.acquire("quad"));
        var texture:Texture = TexturePool.acquire("texture");
        addFromInstance(new TextureUtils(new TextureShader(), texture));

        _speed = 2;
    }

    override public function start():void {
        super.start();

        transform.position.x = -2;
        transform.position.y = 2;
    }

    override public function update():void {
        super.update();

        /*
        transform.rotation.x += 1.0 * _speed;
        transform.rotation.y += 0.5 * _speed;
        transform.rotation.z += 0.25 * _speed

        trace("update", transform.rotation);
        */
    }

    override public function dispose():void {
        super.dispose();

        _speed = null;
    }

}

}
