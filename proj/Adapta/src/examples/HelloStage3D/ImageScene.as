/**
 * Created by hlavko on 28.05.2014.
 */
package examples.HelloStage3D {

import adapta.core.Adapta;
import adapta.core.Scene;
import adapta.geometry.MeshPool;
import adapta.material.TextureUtils;
import adapta.material.TexturePool;

public class ImageScene extends Scene {

    public function ImageScene() {
        super();
    }

    override public function start():void {
        MeshPool.add(new Quad("quad"));
        TexturePool.add("texture", TextureUtils.createTextureFromBitmap(new Assets.BackgroundTexture(), true, 512, 512));

        Adapta.add(new Image1());
        Adapta.add(new Image2());
        Adapta.add(new Image3());
        Adapta.add(new Image4());
    }
}

}
