/**
 * Created by hlavko on 17.06.2014.
 */
package examples.LightingScene.entity {

import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.ShaderPool;
import adapta.material.TexturePool;

import examples.LightingScene.component.CubeRenderer;
import examples.LightingScene.component.DiffusalLighting;

public class MiddleCube extends Entity {

    public function MiddleCube() {
    }

    override public function init():void {
        addFromClass(DiffusalLighting);

        var renderer:CubeRenderer = addFromClass(CubeRenderer) as CubeRenderer;
        //renderer.mesh = MeshPool.acquire("quad");
        renderer.mesh = MeshPool.acquire("cube");
        renderer.texture = TexturePool.acquire("texture");
        renderer.shader = ShaderPool.acquire("DiffusalLightingShader");
    }

    override public function start():void {
        super.start();
    }

    override public function update():void {
        super.update();


        this.transform.rotation.x += 0.1;
        this.transform.rotation.y += 0.2;
        this.transform.rotation.z += 0.3;
    }

    override public function dispose():void {
        super.dispose();
    }

}

}
