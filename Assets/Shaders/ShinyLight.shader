Shader "Custom/ShinyLight"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SecondaryTex("SecondaryTex", 2D) = "white" {}
		_Speed("Speed", Range(0.0, 20.0)) = 1.0
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				half4 vertex : POSITION;
				half2 uv : TEXCOORD0;
			};

			struct v2f
			{
				half2 uv : TEXCOORD0;
				half4 vertex : SV_POSITION;
			};

			sampler2D_half _MainTex, _SecondaryTex;
			half4 _MainTex_ST;
			half _Speed;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float deltaX = (i.uv.x + _SinTime.w * _Speed);
				half4 main = tex2D(_MainTex, i.uv);
				half4 secondary = tex2D(_SecondaryTex, deltaX);
			    half4 output = main + secondary;
			    output.a = main.a;
			   	return output;
			}
			ENDCG
		}
	}
}
