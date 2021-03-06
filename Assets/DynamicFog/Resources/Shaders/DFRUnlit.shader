Shader "DynamicFog/Reflections/Unlit" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ReflectionTex ("Reflections (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma target 3.0

		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float4 _MainTex_ST;
		sampler2D _ReflectionTex;
		fixed4 _Color;

		struct v2f {
			float4 pos: SV_POSITION;
			float2 uv: TEXCOORD0;
			float3 worldPos: TEXCOORD1;
			float4 screenPos: TEXCOORD2;
		};

		#include "DFMVertexFragmentShaderCommon.cginc"

		v2f vert(appdata v) {
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
			o.screenPos = ComputeScreenPos(o.pos);
			o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			return o;
		}

		fixed4 frag (v2f IN): SV_Target {
			fixed4 c = tex2D (_MainTex, IN.uv);
			fixed4 r = tex2D (_ReflectionTex, IN.screenPos.xy / IN.screenPos.w);
			c = c * r * _Color;
			fogColor(IN.worldPos, c);
	 		return c;
		}

		ENDCG
		}
	}
	FallBack "Diffuse"
}
