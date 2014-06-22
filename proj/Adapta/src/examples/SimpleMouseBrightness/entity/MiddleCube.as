/**
 * Created by hlavko on 17.06.2014.
 */
package examples.SimpleMouseBrightness.entity {

import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.ShaderPool;
import adapta.material.TexturePool;

import examples.SimpleMouseBrightness.component.CubeRenderer;
import examples.SimpleMouseBrightness.component.MouseMask;

public class MiddleCube extends Entity {

    public function MiddleCube() {
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
    }

    override public function update():void {
        super.update();
    }

    override public function dispose():void {
        super.dispose();
    }

}

}
