/**
 * Created by hlavko on 03.06.2014.
 */
package examples.SimpleMouseBrightness.entity {

import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.ShaderPool;
import adapta.material.TexturePool;

import examples.SimpleMouseBrightness.component.CubeRenderer;
import examples.SimpleMouseBrightness.component.MouseMask;

public class Cube extends Entity {

    public function Cube() {
    }

    override public function init():void {
        addFromClass(MouseMask);

        var renderer:CubeRenderer = addFromClass(CubeRenderer) as CubeRenderer;
        //renderer.mesh = MeshPool.acquire("quad");
        renderer.mesh = MeshPool.acquire("cube");
        renderer.texture = TexturePool.acquire("texture");
        renderer.shader = ShaderPool.acquire("MouseMaskShader");
    }

    override public function start():void {
        super.start();

        this.transform.scale.x = 0.5 + Math.random() * 2;
        this.transform.position.x = -10 + Math.random() * 20;
        this.transform.position.y = Math.random() * 5;
        this.transform.position.z = -5 + Math.random() * 10;
    }

    override public function update():void {
        super.update();

        this.transform.rotation.x += Math.random();
        this.transform.rotation.y += Math.random();
        this.transform.rotation.z += Math.random();
    }

    override public function dispose():void {
        super.dispose();
    }

}

}
