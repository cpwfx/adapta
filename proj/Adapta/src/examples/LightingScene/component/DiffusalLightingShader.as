/**
 * Created by hlavko on 03.06.2014.
 */
package examples.LightingScene.component {

import adapta.material.Shader;

public class DiffusalLightingShader extends Shader {

    public function DiffusalLightingShader() {
        super("DiffusalLightingShader");
    }

    override protected function vertexShader():XML {
        return <shader>
        m44 op, va0, vc0
        mov v0, va0
        mov v1, va1
        m44 vt0, va2, vc4
        nrm vt0.xyz, vt0
        mov v2, vt0
        </shader>;

        /*
         m44 op, va0, vc0           transform vertex coords to model-view-projection matrix
         mov v0, va0                send vertices to fs
         mov v1, va1                send UV coords to fs
         m44 vt0, va2, vc4          transform normals with model matrix
         nrm vt0.xyz, vt0           normalize transformed normals
         mov v2, vt0                and send them to fs
         */
    }

    override protected function fragmentShader():XML {
        return <shader>
        tex ft0, v1, fs[2d,repeat,linear]
        mov ft2, fc2
        nrm ft2.xyz, ft2
        neg ft2, ft2
        dp3 ft1, v2, ft2
        mul ft1, ft1, ft0
        mul ft1, ft1, fc3
        sat ft1, ft1
        add ft1, ft1, fc1
        sat oc, ft1
        </shader>;

        /*
         tex ft0, v1, fs[2d,repeat,mip_linear]          sample texture
         mov ft2, fc2                                   move light direction to ft2
         nrm ft2.xyz, ft2                               normalize light direction
         neg ft2, ft2                                   negate light direction because
         dp3 ft1, v2, ft2                               we are going to calculate diffusion using dot-product with normals
         sat ft1, ft1                                   clamp diffusion to <0,1>
         mul ft1, ft1, ft0                              multiply diffusion with texture
         sat ft1, ft1                                   clamp result to <0,1>
         mul ft1, ft1, fc3                              multiply state with target color value
         sat ft1, ft1                                   clamp result to <0,1>
         add ft1, ft1, fc1                              add ambient color value to current state
         sat oc, ft1                                    clamp result to <0,1>
         */

    }

}

}
