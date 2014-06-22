/**
 * Created by hlavko on 03.06.2014.
 */
package examples.LightingScene {

import adapta.components.cameras.FreeLookCamera3D;
import adapta.components.lights.DirectionalLight;
import adapta.core.Adapta;
import adapta.core.Scene;
import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.ShaderPool;
import adapta.material.TexturePool;
import adapta.material.TextureUtils;

import examples.LightingScene.component.CubeMesh;
import examples.LightingScene.component.DiffusalLightingShader;
import examples.LightingScene.entity.Character;
import examples.LightingScene.entity.MiddleCube;

public class LightingScene extends Scene {

    public function LightingScene() {
        super();
    }

    override public function start():void {
        //MeshPool.add(new Quad("quad"));
        MeshPool.add(new CubeMesh("cube"));
        TexturePool.add("texture", TextureUtils.createTextureFromBitmap(new Assets.BackgroundTexture(), true, 512, 512));
        ShaderPool.add(new DiffusalLightingShader());

        _camera = new FreeLookCamera3D();
        _light = new DirectionalLight();

        var character:Character = new Character();
        character.addFromInstance(_light);
        character.addFromInstance(_camera);
        Adapta.add(character);

        var mc1:MiddleCube = new MiddleCube();
        mc1.transform.position.x = 1.1;
        mc1.transform.position.y = 1.1;

        var mc2:MiddleCube = new MiddleCube();
        mc2.transform.position.x = -1.1;
        mc2.transform.position.y = 1.1;

        var mc3:MiddleCube = new MiddleCube();
        mc3.transform.position.x = 1.1;
        mc3.transform.position.y = -1.1;

        var mc4:MiddleCube = new MiddleCube();
        mc4.transform.position.x = -1.1;
        mc4.transform.position.y = -1.1;

        Adapta.add(mc1);
        Adapta.add(mc2);
        Adapta.add(mc3);
        Adapta.add(mc4);
    }

}

}
