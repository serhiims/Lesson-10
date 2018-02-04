﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/JellyShader" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Delta ("Delta", float) = 0.0
	}
	SubShader {
        Pass {
    	    Tags { "RenderType"="Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float _Delta;

            struct v2f {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };

            v2f vert(appdata_base v) {
                v2f o;
				v.vertex.x += sign(v.vertex.x) * sin(_Delta)/50;
				v.vertex.y += sign(v.vertex.y) * cos(_Delta)/50;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }


			half4 frag(v2f i) : COLOR {
                half4 c = tex2D(_MainTex, i.uv);
                return c;
            }

			ENDCG
		}
	} 
}