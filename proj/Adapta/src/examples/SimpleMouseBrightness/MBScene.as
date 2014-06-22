/**
 * Created by hlavko on 03.06.2014.
 */
package examples.SimpleMouseBrightness {

import adapta.components.cameras.PerspectiveArcBallCamera3D;
import adapta.components.cameras.FreeLookCamera3D;
import adapta.components.cameras.ArcBallCamera3D;
import adapta.core.Adapta;
import adapta.core.Scene;
import adapta.components.cameras.Camera;
import adapta.entities.Entity;
import adapta.geometry.MeshPool;
import adapta.material.ShaderPool;
import adapta.material.TexturePool;
import adapta.material.TextureUtils;

import examples.SimpleMouseBrightness.component.CubeMesh;
import examples.SimpleMouseBrightness.component.MouseMaskShader;
import adapta.components.cameras.PerspectiveCamera3D;
import examples.SimpleMouseBrightness.entity.Cube;
import examples.SimpleMouseBrightness.entity.MiddleCube;

public class MBScene extends Scene {

    public function MBScene() {
        super();
    }

    override public function start():void {
        //MeshPool.add(new Quad("quad"));
        MeshPool.add(new CubeMesh("cube"));
        TexturePool.add("texture", TextureUtils.createTextureFromBitmap(new Assets.BackgroundTexture(), true, 512, 512));
        ShaderPool.add(new MouseMaskShader());

        //_camera = new PerspectiveCamera3D();
        //_camera = new FreeLookCamera3D();
        //_camera = new PerspectiveArcBallCamera3D();
        _camera = new ArcBallCamera3D();
        var cameraObject:Entity = new Entity();
        cameraObject.addFromInstance(_camera);
        Adapta.add(cameraObject);

        //Adapta.add(new Cube());
        //Adapta.add(new Cube());
        //Adapta.add(new Cube());
        //Adapta.add(new Cube());
        //Adapta.add(new Cube());
        //Adapta.add(new Cube());

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
