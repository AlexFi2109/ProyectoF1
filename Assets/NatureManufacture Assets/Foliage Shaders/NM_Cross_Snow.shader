Shader "NatureManufacture/HDRP/Foliage/Cross Snow"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Float) = 0.5
        [NoScaleOffset]_BaseColorMap("Base Map", 2D) = "white" {}
        _TilingOffset("Tiling and Offset", Vector) = (1, 1, 0, 0)
        _HealthyColor("Healthy Color", Color) = (1, 1, 1, 0)
        _DryColor("Dry Color", Color) = (0.8196079, 0.8196079, 0.8196079, 0)
        _ColorNoiseSpread("Color Noise Spread", Float) = 2
        [NoScaleOffset]_NormalMap("Normal Map", 2D) = "bump" {}
        _NormalScale("Normal Scale", Range(0, 8)) = 1
        _AORemapMax("AO Remap Max", Range(0, 1)) = 1
        _SmoothnessRemapMax("Smoothness Remap Max", Range(0, 1)) = 1
        _Thickness("Thickness", Range(0, 1)) = 0.3
        _Snow_Amount("Snow Amount", Range(0, 2)) = 0
        _SnowBaseColor("Snow Base Color", Color) = (1, 1, 1, 0)
        _SnowColorAdjustment("Snow Color Adjustment", Vector) = (1, 1, 1, 0)
        [NoScaleOffset]_SnowMaskA("Snow Mask(A)", 2D) = "black" {}
        _SnowMaskTreshold("Snow Mask Treshold", Range(0.1, 15)) = 4
        [ToggleUI]_InvertSnowMask("Invert Snow Mask", Float) = 0
        [NoScaleOffset]_SnowBaseColorMap("Snow Base Map", 2D) = "white" {}
        _SnowTilingOffset("Snow Tiling Offset", Vector) = (1, 1, 0, 0)
        _SnowBlendHardness("Snow Blend Hardness", Range(0, 8)) = 1
        _SnowAORemapMax("Snow AO Remap Max", Range(0, 1)) = 1
        _SnowSmoothnessRemapMax("Snow Smoothness Remap Max", Range(0, 1)) = 1
        _SnowThickness("Snow Thickness", Range(0, 1)) = 0.3
        _Stiffness("Wind Stiffness", Float) = 0
        _InitialBend("Wind Initial Bend", Float) = 0
        _Drag("Wind Drag", Float) = 0
        _WindNormalInfluence("Wind Normal Influence", Float) = 0
        _VertexNormalMultiply("Wind Vertex Normal Multiply", Vector) = (0, 0, 0, 0)
        _NewNormal("Mesh Normal Multiply", Vector) = (0, 0, 0, 0)
        [HideInInspector]_EmissionColor("Color", Color) = (1, 1, 1, 1)
        [HideInInspector]_RenderQueueType("Vector1", Float) = 1
        [HideInInspector]_StencilRef("Vector1", Int) = 0
        [HideInInspector]_StencilWriteMask("Vector1", Int) = 6
        [HideInInspector]_StencilRefDepth("Vector1", Int) = 8
        [HideInInspector]_StencilWriteMaskDepth("Vector1", Int) = 8
        [HideInInspector]_StencilRefMV("Vector1", Int) = 40
        [HideInInspector]_StencilWriteMaskMV("Vector1", Int) = 40
        [HideInInspector]_StencilRefDistortionVec("Vector1", Int) = 4
        [HideInInspector]_StencilWriteMaskDistortionVec("Vector1", Int) = 4
        [HideInInspector]_StencilWriteMaskGBuffer("Vector1", Int) = 14
        [HideInInspector]_StencilRefGBuffer("Vector1", Int) = 10
        [HideInInspector]_ZTestGBuffer("Vector1", Int) = 4
        [HideInInspector][ToggleUI]_RequireSplitLighting("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_ReceivesSSR("Boolean", Float) = 1
        [HideInInspector]_SurfaceType("Vector1", Float) = 0
        [HideInInspector]_BlendMode("Vector1", Float) = 0
        [HideInInspector]_SrcBlend("Vector1", Float) = 1
        [HideInInspector]_DstBlend("Vector1", Float) = 0
        [HideInInspector]_AlphaSrcBlend("Vector1", Float) = 1
        [HideInInspector]_AlphaDstBlend("Vector1", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_TransparentZWrite("Boolean", Float) = 0
        [HideInInspector]_CullMode("Vector1", Float) = 2
        [HideInInspector]_TransparentSortPriority("Vector1", Int) = 0
        [HideInInspector][ToggleUI]_EnableFogOnTransparent("Boolean", Float) = 1
        [HideInInspector]_CullModeForward("Vector1", Float) = 2
        [HideInInspector][Enum(Front, 1, Back, 2)]_TransparentCullMode("Vector1", Float) = 2
        [HideInInspector]_ZTestDepthEqualForOpaque("Vector1", Int) = 4
        [HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)]_ZTestTransparent("Vector1", Float) = 4
        [HideInInspector][ToggleUI]_TransparentBackfaceEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_AlphaCutoffEnable("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_UseShadowThreshold("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_DoubleSidedEnable("Boolean", Float) = 1
        [HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)]_DoubleSidedNormalMode("Vector1", Float) = 1
        [HideInInspector]_DoubleSidedConstants("Vector4", Vector) = (1, 1, -1, 0)
        [HideInInspector]_DiffusionProfileHash("Vector1", Float) = 0
        [HideInInspector]_DiffusionProfileAsset("Vector4", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDLitShader"
            "Queue" = "AlphaTest+0"
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            ZClip [_ZClip]
        
            
            ColorMask 0
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_SHADOWS
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   LodCrossFade
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            // #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            // #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float4 interp00 : TEXCOORD0; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.interp00.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 TangentSpaceNormal; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    // output.positionRWS = input.positionRWS;
                    // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    // output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                // surfaceData.baseColor =                 surfaceDescription.Albedo;
                // surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                // surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                // surfaceData.thickness =                 surfaceDescription.Thickness;
                // surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                // surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                // normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "META"
            Tags { "LightMode" = "META" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull Off
        
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.uv0
                //   AttributesMesh.uv1
                //   AttributesMesh.color
                //   AttributesMesh.uv2
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.positionOS
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                float4 uv1 : TEXCOORD1; // optional
                float4 uv2 : TEXCOORD2; // optional
                float4 color : COLOR; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                // output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                // vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                // input.positionOS = vertexDescription.VertexPosition;
                // input.normalOS = vertexDescription.VertexNormal;
                // input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassLightTransport.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "SceneSelectionPass"
            Tags { "LightMode" = "SceneSelectionPass" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            ColorMask 0
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_DEPTH_ONLY
                #define SCENESELECTIONPASS
                #pragma editor_sync_compilation
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   LodCrossFade
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            // #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            // #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float4 interp00 : TEXCOORD0; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.interp00.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 TangentSpaceNormal; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    // output.positionRWS = input.positionRWS;
                    // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    // output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                // surfaceData.baseColor =                 surfaceDescription.Albedo;
                // surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                // surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                // surfaceData.thickness =                 surfaceDescription.Thickness;
                // surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                // surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                // normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "DepthOnly"
            Tags { "LightMode" = "DepthOnly" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMaskDepth]
           Ref [_StencilRefDepth]
           Comp Always
           Pass Replace
        }
        
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_DEPTH_ONLY
                #pragma multi_compile _ WRITE_NORMAL_BUFFER
                #pragma multi_compile _ WRITE_MSAA_DEPTH
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Normal
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.uv0
                //   AttributesMesh.uv1
                //   AttributesMesh.color
                //   AttributesMesh.uv2
                //   AttributesMesh.uv3
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   FragInputs.texCoord1
                //   FragInputs.texCoord2
                //   FragInputs.texCoord3
                //   FragInputs.color
                //   VaryingsMeshToPS.cullFace
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   VaryingsMeshToPS.texCoord1
                //   VaryingsMeshToPS.texCoord2
                //   VaryingsMeshToPS.texCoord3
                //   VaryingsMeshToPS.color
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            // #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                float4 uv1 : TEXCOORD1; // optional
                float4 uv2 : TEXCOORD2; // optional
                float4 uv3 : TEXCOORD3; // optional
                float4 color : COLOR; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                float4 texCoord1; // optional
                float4 texCoord2; // optional
                float4 texCoord3; // optional
                float4 color; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                float4 interp04 : TEXCOORD4; // auto-packed
                float4 interp05 : TEXCOORD5; // auto-packed
                float4 interp06 : TEXCOORD6; // auto-packed
                float4 interp07 : TEXCOORD7; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord1;
                output.interp05.xyzw = input.texCoord2;
                output.interp06.xyzw = input.texCoord3;
                output.interp07.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord1 = input.interp04.xyzw;
                output.texCoord2 = input.interp05.xyzw;
                output.texCoord3 = input.interp06.xyzw;
                output.color = input.interp07.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Normal;
                        float Smoothness;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    output.texCoord1 = input.texCoord1;
                    output.texCoord2 = input.texCoord2;
                    output.texCoord3 = input.texCoord3;
                    output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                // surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                // surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                // surfaceData.thickness =                 surfaceDescription.Thickness;
                // surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                // surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "GBuffer"
            Tags { "LightMode" = "GBuffer" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            ZTest [_ZTestGBuffer]
        
            
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMaskGBuffer]
           Ref [_StencilRefGBuffer]
           Comp Always
           Pass Replace
        }
        
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_GBUFFER
                #pragma multi_compile _ DEBUG_DISPLAY
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                #pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
                #pragma multi_compile _ LIGHT_LAYERS
                #define RAYTRACING_SHADER_GRAPH_HIGH
                #ifndef DEBUG_DISPLAY
    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
    #endif
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord1
                //   FragInputs.texCoord2
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord1
                //   VaryingsMeshToPS.texCoord2
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv1
                //   AttributesMesh.uv2
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                float4 uv1 : TEXCOORD1; // optional
                float4 uv2 : TEXCOORD2; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                float4 texCoord1; // optional
                float4 texCoord2; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                float4 interp04 : TEXCOORD4; // auto-packed
                float4 interp05 : TEXCOORD5; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord1;
                output.interp05.xyzw = input.texCoord2;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord1 = input.interp04.xyzw;
                output.texCoord2 = input.interp05.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    output.texCoord1 = input.texCoord1;
                    output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassGBuffer.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "MotionVectors"
            Tags { "LightMode" = "MotionVectors" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMaskMV]
           Ref [_StencilRefMV]
           Comp Always
           Pass Replace
        }
        
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_MOTION_VECTORS
                #pragma multi_compile _ WRITE_NORMAL_BUFFER
                #pragma multi_compile _ WRITE_MSAA_DEPTH
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Normal
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.uv0
                //   AttributesMesh.uv1
                //   AttributesMesh.color
                //   AttributesMesh.uv2
                //   AttributesMesh.uv3
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   FragInputs.texCoord1
                //   FragInputs.texCoord2
                //   FragInputs.texCoord3
                //   FragInputs.color
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   VaryingsMeshToPS.texCoord1
                //   VaryingsMeshToPS.texCoord2
                //   VaryingsMeshToPS.texCoord3
                //   VaryingsMeshToPS.color
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            // #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                float4 uv1 : TEXCOORD1; // optional
                float4 uv2 : TEXCOORD2; // optional
                float4 uv3 : TEXCOORD3; // optional
                float4 color : COLOR; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                float4 texCoord1; // optional
                float4 texCoord2; // optional
                float4 texCoord3; // optional
                float4 color; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                float4 interp04 : TEXCOORD4; // auto-packed
                float4 interp05 : TEXCOORD5; // auto-packed
                float4 interp06 : TEXCOORD6; // auto-packed
                float4 interp07 : TEXCOORD7; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord1;
                output.interp05.xyzw = input.texCoord2;
                output.interp06.xyzw = input.texCoord3;
                output.interp07.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord1 = input.interp04.xyzw;
                output.texCoord2 = input.interp05.xyzw;
                output.texCoord3 = input.interp06.xyzw;
                output.color = input.interp07.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Normal;
                        float Smoothness;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    output.texCoord1 = input.texCoord1;
                    output.texCoord2 = input.texCoord2;
                    output.texCoord3 = input.texCoord3;
                    output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                // surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                // surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                // surfaceData.thickness =                 surfaceDescription.Thickness;
                // surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                // surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassMotionVectors.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "Forward"
            Tags { "LightMode" = "Forward" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
        
            Cull [_CullModeForward]
        
            ZTest Equal
        
            ZWrite [_ZWrite]
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMask]
           Ref [_StencilRef]
           Comp Always
           Pass Replace
        }
        
            ColorMask [_ColorMaskTransparentVel] 1
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_FORWARD
                #pragma multi_compile _ DEBUG_DISPLAY
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                #pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
                #pragma multi_compile USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
                #pragma multi_compile SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH
                #ifndef DEBUG_DISPLAY
    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
    #endif
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord1
                //   FragInputs.texCoord2
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord1
                //   VaryingsMeshToPS.texCoord2
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv1
                //   AttributesMesh.uv2
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma vertex Vert
                #pragma fragment Frag
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                float4 uv1 : TEXCOORD1; // optional
                float4 uv2 : TEXCOORD2; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                float4 texCoord1; // optional
                float4 texCoord2; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                float4 interp04 : TEXCOORD4; // auto-packed
                float4 interp05 : TEXCOORD5; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord1;
                output.interp05.xyzw = input.texCoord2;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord1 = input.interp04.xyzw;
                output.texCoord2 = input.interp05.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    output.texCoord1 = input.texCoord1;
                    output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForward.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "IndirectDXR"
            Tags { "LightMode" = "IndirectDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_RAYTRACING_INDIRECT
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #pragma multi_compile _ DIFFUSE_LIGHTING_ONLY
                #define SHADOW_LOW
                #define RAYTRACING_SHADER_GRAPH_LOW
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingIndirect.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "VisibilityDXR"
            Tags { "LightMode" = "VisibilityDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_RAYTRACING_VISIBILITY
                #pragma multi_compile _ TRANSPARENT_COLOR_SHADOW
                #define RAYTRACING_SHADER_GRAPH_LOW
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingVisibility.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "ForwardDXR"
            Tags { "LightMode" = "ForwardDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_RAYTRACING_FORWARD
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #define SHADOW_LOW
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingForward.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "GBufferDXR"
            Tags { "LightMode" = "GBufferDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_RAYTRACING_GBUFFER
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #define SHADOW_LOW
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderpassRaytracingGBuffer.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "SubSurfaceDXR"
            Tags { "LightMode" = "SubSurfaceDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_RAYTRACING_SUB_SURFACE
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ DYNAMICLIGHTMAP_ON
                #define SHADOW_LOW
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderpassRaytracingSubSurface.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDLitPass.template
            Name "PathTracingDXR"
            Tags { "LightMode" = "PathTracingDXR" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            #pragma multi_compile_instancing
        #pragma instancing_options nolightprobe
        #pragma instancing_options nolodfade
        
            #pragma multi_compile _ LOD_FADE_CROSSFADE
        
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _DOUBLESIDED_ON
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
            #pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ALPHATEST_ON
        
            //-------------------------------------------------------------------------------------
            // Graph Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_PATH_TRACING
                #define SHADOW_LOW
                #define RAYTRACING_SHADER_GRAPH_HIGH
                // ACTIVE FIELDS:
                //   DoubleSided
                //   DoubleSided.Mirror
                //   FragInputs.isFrontFace
                //   NormalDropOffTS
                //   Material.Translucent
                //   Material.Transmission
                //   AlphaTest
                //   Specular.EnergyConserving
                //   SpecularOcclusionFromAO
                //   AmbientOcclusion
                //   LodCrossFade
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.TangentSpaceNormal
                //   SurfaceDescriptionInputs.AbsoluteWorldSpacePosition
                //   SurfaceDescriptionInputs.uv0
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.ObjectSpaceTangent
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   SurfaceDescription.Albedo
                //   SurfaceDescription.Normal
                //   SurfaceDescription.BentNormal
                //   SurfaceDescription.Thickness
                //   SurfaceDescription.DiffusionProfileHash
                //   SurfaceDescription.CoatMask
                //   SurfaceDescription.Emission
                //   SurfaceDescription.Smoothness
                //   SurfaceDescription.Occlusion
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescription.VertexPosition
                //   VertexDescription.VertexNormal
                //   VertexDescription.VertexTangent
                //   VaryingsMeshToPS.cullFace
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   FragInputs.texCoord0
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   VaryingsMeshToPS.texCoord0
                //   AttributesMesh.uv0
                // Shared Graph Keywords
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Variant Definitions (active field translations to HDRP defines)
            //-------------------------------------------------------------------------------------
        
            // #define _MATERIAL_FEATURE_SUBSURFACE_SCATTERING 1
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            // #define _MATERIAL_FEATURE_ANISOTROPY 1
            // #define _MATERIAL_FEATURE_IRIDESCENCE 1
            // #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _AMBIENT_OCCLUSION 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            // #define _SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL 1
            // #define _SPECULAR_OCCLUSION_CUSTOM 1
            #define _ENERGY_CONSERVING_SPECULAR 1
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // #define _ENABLE_GEOMETRIC_SPECULAR_AA 1
        #endif
            // #define _HAS_REFRACTION 1
            // #define _REFRACTION_PLANE 1
            // #define _REFRACTION_SPHERE 1
            // #define _REFRACTION_THIN 1
            // #define _DISABLE_DECALS 1
            // #define _DISABLE_SSR 1
            // #define _ADD_PRECOMPUTED_VELOCITY
            // #define _WRITE_TRANSPARENT_MOTION_VECTOR 1
            // #define _DEPTHOFFSET_ON 1
            // #define _BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
            #define _NORMAL_DROPOFF_TS 1
            // #define _NORMAL_DROPOFF_OS 1
            // #define _NORMAL_DROPOFF_WS 1
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Shader stages
            //-------------------------------------------------------------------------------------
                    #pragma raytracing surface_shader
        
            // If we use subsurface scattering, enable output split lighting (for forward pass)
            #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This cannot be included, the instructions that are required are not defined if we are not in a rasterization context
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #endif
        
            // define FragInputs structure
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Active Field Defines
            //-------------------------------------------------------------------------------------
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
        // We need isFontFace when using double sided
        #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
            #define VARYINGS_NEED_CULLFACE
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
        	
        #if !defined(SHADER_STAGE_RAY_TRACING)
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #ifdef DEBUG_DISPLAY
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        
            #if (SHADERPASS == SHADERPASS_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        
                #define HAS_LIGHTLOOP
        
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #else
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
            #elif (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/SubSurface/RayTracingIntersectionSubSurface.hlsl"
            #else
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
            #endif
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD) || (SHADERPASS == SHADERPASS_PATH_TRACING)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
                #define HAS_LIGHTLOOP
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRaytracing.hlsl"
            #if (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
            #endif
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingCommon.hlsl"
        #endif
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // This types only make sense in the rasterization pipeline
            // Generated Type: AttributesMesh
            struct AttributesMesh
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; // optional
                float4 tangentOS : TANGENT; // optional
                float4 uv0 : TEXCOORD0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            // Generated Type: VaryingsMeshToPS
            struct VaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION;
                float3 positionRWS; // optional
                float3 normalWS; // optional
                float4 tangentWS; // optional
                float4 texCoord0; // optional
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            };
            
            // Generated Type: PackedVaryingsMeshToPS
            struct PackedVaryingsMeshToPS
            {
                float4 positionCS : SV_POSITION; // unpacked
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
                float4 interp02 : TEXCOORD2; // auto-packed
                float4 interp03 : TEXCOORD3; // auto-packed
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
                #endif // conditional
            };
            
            // Packed Type: VaryingsMeshToPS
            PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
            {
                PackedVaryingsMeshToPS output = (PackedVaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToPS
            VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
            {
                VaryingsMeshToPS output = (VaryingsMeshToPS)0;
                output.positionCS = input.positionCS;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif // conditional
                return output;
            }
            // Generated Type: VaryingsMeshToDS
            struct VaryingsMeshToDS
            {
                float3 positionRWS;
                float3 normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif // UNITY_ANY_INSTANCING_ENABLED
            };
            
            // Generated Type: PackedVaryingsMeshToDS
            struct PackedVaryingsMeshToDS
            {
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
                #endif // conditional
                float3 interp00 : TEXCOORD0; // auto-packed
                float3 interp01 : TEXCOORD1; // auto-packed
            };
            
            // Packed Type: VaryingsMeshToDS
            PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
            {
                PackedVaryingsMeshToDS output = (PackedVaryingsMeshToDS)0;
                output.interp00.xyz = input.positionRWS;
                output.interp01.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
            
            // Unpacked Type: VaryingsMeshToDS
            VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
            {
                VaryingsMeshToDS output = (VaryingsMeshToDS)0;
                output.positionRWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif // conditional
                return output;
            }
        #endif
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float _AlphaCutoff;
                    float4 _TilingOffset;
                    float4 _HealthyColor;
                    float4 _DryColor;
                    float _ColorNoiseSpread;
                    float _NormalScale;
                    float _AORemapMax;
                    float _SmoothnessRemapMax;
                    float _Thickness;
                    float _Snow_Amount;
                    float4 _SnowBaseColor;
                    float3 _SnowColorAdjustment;
                    float _SnowMaskTreshold;
                    float _InvertSnowMask;
                    float4 _SnowTilingOffset;
                    float _SnowBlendHardness;
                    float _SnowAORemapMax;
                    float _SnowSmoothnessRemapMax;
                    float _SnowThickness;
                    float _Stiffness;
                    float _InitialBend;
                    float _Drag;
                    float _WindNormalInfluence;
                    float4 _VertexNormalMultiply;
                    float4 _NewNormal;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _TransparentZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _EnableFogOnTransparent;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    float _DiffusionProfileHash;
                    float4 _DiffusionProfileAsset;
                    CBUFFER_END
                    TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
                    TEXTURE2D(_NormalMap); SAMPLER(sampler_NormalMap); float4 _NormalMap_TexelSize;
                    TEXTURE2D(_SnowMaskA); SAMPLER(sampler_SnowMaskA); float4 _SnowMaskA_TexelSize;
                    TEXTURE2D(_SnowBaseColorMap); SAMPLER(sampler_SnowBaseColorMap); float4 _SnowBaseColorMap_TexelSize;
                    SAMPLER(_SampleTexture2D_3E7E8460_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_B9157A33_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A6FC7442_Sampler_3_Linear_Repeat);
                    SAMPLER(_SampleTexture2D_A36F2461_Sampler_3_Linear_Repeat);
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs
                    {
                        float3 ObjectSpaceNormal; // optional
                        float3 ObjectSpaceTangent; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 VertexPosition;
                        float3 VertexNormal;
                        float3 VertexTangent;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs
                    {
                        float3 WorldSpaceNormal; // optional
                        float3 TangentSpaceNormal; // optional
                        float3 AbsoluteWorldSpacePosition; // optional
                        float4 uv0; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Albedo;
                        float3 Normal;
                        float3 BentNormal;
                        float Thickness;
                        float DiffusionProfileHash;
                        float CoatMask;
                        float3 Emission;
                        float Smoothness;
                        float Occlusion;
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
                inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
                {
                    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
                }
                
                inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
                {
                    return (1.0-t)*a + (t*b);
                }
                
                
                inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
                {
                    float2 i = floor(uv);
                    float2 f = frac(uv);
                    f = f * f * (3.0 - 2.0 * f);
                
                    uv = abs(frac(uv) - 0.5);
                    float2 c0 = i + float2(0.0, 0.0);
                    float2 c1 = i + float2(1.0, 0.0);
                    float2 c2 = i + float2(0.0, 1.0);
                    float2 c3 = i + float2(1.0, 1.0);
                    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
                
                    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                    return t;
                }
                    void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
                    {
                        float t = 0.0;
                
                        float freq = pow(2.0, float(0));
                        float amp = pow(0.5, float(3-0));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(1));
                        amp = pow(0.5, float(3-1));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        freq = pow(2.0, float(2));
                        amp = pow(0.5, float(3-2));
                        t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
                
                        Out = t;
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                    {
                        Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                    }
                
                    void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
                    {
                        Out = normalize(float3(A.rg + B.rg, A.b * B.b));
                    }
                
                    void Unity_Multiply_float(float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Clamp_float(float In, float Min, float Max, out float Out)
                    {
                        Out = clamp(In, Min, Max);
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_OneMinus_float(float In, out float Out)
                    {
                        Out = 1 - In;
                    }
                
                    void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                    {
                        Out = lerp(False, True, Predicate);
                    }
                
                    void Unity_Lerp_float(float A, float B, float T, out float Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    // 02092042f8fbe23da7886005ee29c06a
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                    void AddPragma_float(float3 A, out float3 Out)
                    {
                        #pragma instancing_options renderinglayer procedural:setupVSPro
                        Out = A;
                    }
                
                    struct Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8
                    {
                    };
                
                    void SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 IN, out float3 ObjectSpacePosition_1)
                    {
                        float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                        float3 _CustomFunction_E07FEE57_Out_1;
                        InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                        float3 _CustomFunction_18EFD858_Out_1;
                        AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                        ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
                    }
                
                    // 928d2c1f4204528bee5f1f2ccf97e3ae
                    #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        Bindings_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8 _NMFoliageVSProIndirect_26DBCB42;
                        float3 _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1;
                        SG_NMFoliageVSProIndirect_7b92be50f852bc440961517e733427f8(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_26DBCB42, _NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1);
                        float3 _CustomFunction_B2A88CC6_vertex_3;
                        float3 _CustomFunction_B2A88CC6_normal_4;
                        CalculateWind_float(_NMFoliageVSProIndirect_26DBCB42_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_B2A88CC6_vertex_3, _CustomFunction_B2A88CC6_normal_4);
                        description.VertexPosition = _CustomFunction_B2A88CC6_vertex_3;
                        description.VertexNormal = IN.ObjectSpaceNormal;
                        description.VertexTangent = IN.ObjectSpaceTangent;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_3E4B16C8_Out_0 = _TilingOffset;
                        float _Split_7DC8027E_R_1 = _Property_3E4B16C8_Out_0[0];
                        float _Split_7DC8027E_G_2 = _Property_3E4B16C8_Out_0[1];
                        float _Split_7DC8027E_B_3 = _Property_3E4B16C8_Out_0[2];
                        float _Split_7DC8027E_A_4 = _Property_3E4B16C8_Out_0[3];
                        float2 _Vector2_5FE3355F_Out_0 = float2(_Split_7DC8027E_R_1, _Split_7DC8027E_G_2);
                        float2 _Vector2_6B41CEB2_Out_0 = float2(_Split_7DC8027E_B_3, _Split_7DC8027E_A_4);
                        float2 _TilingAndOffset_E3C6FAD6_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_5FE3355F_Out_0, _Vector2_6B41CEB2_Out_0, _TilingAndOffset_E3C6FAD6_Out_3);
                        float4 _SampleTexture2D_3E7E8460_RGBA_0 = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        float _SampleTexture2D_3E7E8460_R_4 = _SampleTexture2D_3E7E8460_RGBA_0.r;
                        float _SampleTexture2D_3E7E8460_G_5 = _SampleTexture2D_3E7E8460_RGBA_0.g;
                        float _SampleTexture2D_3E7E8460_B_6 = _SampleTexture2D_3E7E8460_RGBA_0.b;
                        float _SampleTexture2D_3E7E8460_A_7 = _SampleTexture2D_3E7E8460_RGBA_0.a;
                        float4 _Property_D528E6_Out_0 = _DryColor;
                        float4 _Property_5DE93B86_Out_0 = _HealthyColor;
                        float _Split_B2D05BFD_R_1 = IN.AbsoluteWorldSpacePosition[0];
                        float _Split_B2D05BFD_G_2 = IN.AbsoluteWorldSpacePosition[1];
                        float _Split_B2D05BFD_B_3 = IN.AbsoluteWorldSpacePosition[2];
                        float _Split_B2D05BFD_A_4 = 0;
                        float2 _Vector2_176AFDF8_Out_0 = float2(_Split_B2D05BFD_R_1, _Split_B2D05BFD_B_3);
                        float _Property_DAB5B06F_Out_0 = _ColorNoiseSpread;
                        float _SimpleNoise_F91A37A3_Out_2;
                        Unity_SimpleNoise_float(_Vector2_176AFDF8_Out_0, _Property_DAB5B06F_Out_0, _SimpleNoise_F91A37A3_Out_2);
                        float4 _Lerp_7661C001_Out_3;
                        Unity_Lerp_float4(_Property_D528E6_Out_0, _Property_5DE93B86_Out_0, (_SimpleNoise_F91A37A3_Out_2.xxxx), _Lerp_7661C001_Out_3);
                        float4 _Multiply_67F895DE_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_3E7E8460_RGBA_0, _Lerp_7661C001_Out_3, _Multiply_67F895DE_Out_2);
                        float3 _Property_F5548308_Out_0 = _SnowColorAdjustment;
                        float4 _Property_772E1291_Out_0 = _SnowTilingOffset;
                        float _Split_B7A54E03_R_1 = _Property_772E1291_Out_0[0];
                        float _Split_B7A54E03_G_2 = _Property_772E1291_Out_0[1];
                        float _Split_B7A54E03_B_3 = _Property_772E1291_Out_0[2];
                        float _Split_B7A54E03_A_4 = _Property_772E1291_Out_0[3];
                        float2 _Vector2_B4FC0B8A_Out_0 = float2(_Split_B7A54E03_R_1, _Split_B7A54E03_G_2);
                        float2 _Vector2_2B07023F_Out_0 = float2(_Split_B7A54E03_B_3, _Split_B7A54E03_A_4);
                        float2 _TilingAndOffset_2231F14C_Out_3;
                        Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_B4FC0B8A_Out_0, _Vector2_2B07023F_Out_0, _TilingAndOffset_2231F14C_Out_3);
                        float4 _SampleTexture2D_B9157A33_RGBA_0 = SAMPLE_TEXTURE2D(_SnowBaseColorMap, sampler_SnowBaseColorMap, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_B9157A33_R_4 = _SampleTexture2D_B9157A33_RGBA_0.r;
                        float _SampleTexture2D_B9157A33_G_5 = _SampleTexture2D_B9157A33_RGBA_0.g;
                        float _SampleTexture2D_B9157A33_B_6 = _SampleTexture2D_B9157A33_RGBA_0.b;
                        float _SampleTexture2D_B9157A33_A_7 = _SampleTexture2D_B9157A33_RGBA_0.a;
                        float4 _Property_420C8395_Out_0 = _SnowBaseColor;
                        float4 _Multiply_205A72D_Out_2;
                        Unity_Multiply_float(_SampleTexture2D_B9157A33_RGBA_0, _Property_420C8395_Out_0, _Multiply_205A72D_Out_2);
                        float3 _Multiply_99338190_Out_2;
                        Unity_Multiply_float(_Property_F5548308_Out_0, (_Multiply_205A72D_Out_2.xyz), _Multiply_99338190_Out_2);
                        float _Property_8A58B76F_Out_0 = _Snow_Amount;
                        float4 _SampleTexture2D_A6FC7442_RGBA_0 = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, _TilingAndOffset_E3C6FAD6_Out_3);
                        _SampleTexture2D_A6FC7442_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_A6FC7442_RGBA_0);
                        float _SampleTexture2D_A6FC7442_R_4 = _SampleTexture2D_A6FC7442_RGBA_0.r;
                        float _SampleTexture2D_A6FC7442_G_5 = _SampleTexture2D_A6FC7442_RGBA_0.g;
                        float _SampleTexture2D_A6FC7442_B_6 = _SampleTexture2D_A6FC7442_RGBA_0.b;
                        float _SampleTexture2D_A6FC7442_A_7 = _SampleTexture2D_A6FC7442_RGBA_0.a;
                        float _Property_1CABD952_Out_0 = _NormalScale;
                        float3 _NormalStrength_EDF1EB8B_Out_2;
                        Unity_NormalStrength_float((_SampleTexture2D_A6FC7442_RGBA_0.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                        float _Property_7B1F642E_Out_0 = _SnowBlendHardness;
                        float3 _NormalStrength_2C761857_Out_2;
                        Unity_NormalStrength_float(_NormalStrength_EDF1EB8B_Out_2, _Property_7B1F642E_Out_0, _NormalStrength_2C761857_Out_2);
                        float3 _NormalBlend_4147D49E_Out_2;
                        Unity_NormalBlend_float(IN.WorldSpaceNormal, _NormalStrength_2C761857_Out_2, _NormalBlend_4147D49E_Out_2);
                        float _Split_EB2C218B_R_1 = _NormalBlend_4147D49E_Out_2[0];
                        float _Split_EB2C218B_G_2 = _NormalBlend_4147D49E_Out_2[1];
                        float _Split_EB2C218B_B_3 = _NormalBlend_4147D49E_Out_2[2];
                        float _Split_EB2C218B_A_4 = 0;
                        float _Multiply_18206C1C_Out_2;
                        Unity_Multiply_float(_Property_8A58B76F_Out_0, _Split_EB2C218B_G_2, _Multiply_18206C1C_Out_2);
                        float _Clamp_8920C3A3_Out_3;
                        Unity_Clamp_float(_Multiply_18206C1C_Out_2, 0, 1, _Clamp_8920C3A3_Out_3);
                        float _Saturate_1BB29A4B_Out_1;
                        Unity_Saturate_float(_Clamp_8920C3A3_Out_3, _Saturate_1BB29A4B_Out_1);
                        float _Property_7CA7C1_Out_0 = _InvertSnowMask;
                        float4 _SampleTexture2D_A36F2461_RGBA_0 = SAMPLE_TEXTURE2D(_SnowMaskA, sampler_SnowMaskA, _TilingAndOffset_2231F14C_Out_3);
                        float _SampleTexture2D_A36F2461_R_4 = _SampleTexture2D_A36F2461_RGBA_0.r;
                        float _SampleTexture2D_A36F2461_G_5 = _SampleTexture2D_A36F2461_RGBA_0.g;
                        float _SampleTexture2D_A36F2461_B_6 = _SampleTexture2D_A36F2461_RGBA_0.b;
                        float _SampleTexture2D_A36F2461_A_7 = _SampleTexture2D_A36F2461_RGBA_0.a;
                        float _OneMinus_327CDB33_Out_1;
                        Unity_OneMinus_float(_SampleTexture2D_A36F2461_A_7, _OneMinus_327CDB33_Out_1);
                        float _Branch_E0D37FD_Out_3;
                        Unity_Branch_float(_Property_7CA7C1_Out_0, _OneMinus_327CDB33_Out_1, _SampleTexture2D_A36F2461_A_7, _Branch_E0D37FD_Out_3);
                        float _Property_4950A9DC_Out_0 = _SnowMaskTreshold;
                        float _Multiply_E5A2F0BF_Out_2;
                        Unity_Multiply_float(_Branch_E0D37FD_Out_3, _Property_4950A9DC_Out_0, _Multiply_E5A2F0BF_Out_2);
                        float _Clamp_891AD698_Out_3;
                        Unity_Clamp_float(_Multiply_E5A2F0BF_Out_2, 0, 1, _Clamp_891AD698_Out_3);
                        float _Lerp_A8EC79BE_Out_3;
                        Unity_Lerp_float(_Saturate_1BB29A4B_Out_1, 1, _Clamp_891AD698_Out_3, _Lerp_A8EC79BE_Out_3);
                        float _Absolute_2EB2EAE7_Out_1;
                        Unity_Absolute_float(_SampleTexture2D_A36F2461_A_7, _Absolute_2EB2EAE7_Out_1);
                        float _Clamp_A4C000AF_Out_3;
                        Unity_Clamp_float(_Property_8A58B76F_Out_0, 0.1, 2, _Clamp_A4C000AF_Out_3);
                        float _Divide_6BF571E1_Out_2;
                        Unity_Divide_float(_Property_4950A9DC_Out_0, _Clamp_A4C000AF_Out_3, _Divide_6BF571E1_Out_2);
                        float _Power_D3A555D1_Out_2;
                        Unity_Power_float(_Absolute_2EB2EAE7_Out_1, _Divide_6BF571E1_Out_2, _Power_D3A555D1_Out_2);
                        float _Lerp_35ABD04D_Out_3;
                        Unity_Lerp_float(0, _Lerp_A8EC79BE_Out_3, _Power_D3A555D1_Out_2, _Lerp_35ABD04D_Out_3);
                        float3 _Lerp_A5D643F2_Out_3;
                        Unity_Lerp_float3((_Multiply_67F895DE_Out_2.xyz), _Multiply_99338190_Out_2, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_A5D643F2_Out_3);
                        float _Property_EDB95586_Out_0 = _Thickness;
                        float _Property_3A018C8A_Out_0 = _SmoothnessRemapMax;
                        float _Property_DF6FBA39_Out_0 = _AORemapMax;
                        float4 _Combine_87F30693_RGBA_4;
                        float3 _Combine_87F30693_RGB_5;
                        float2 _Combine_87F30693_RG_6;
                        Unity_Combine_float(_Property_EDB95586_Out_0, _Property_3A018C8A_Out_0, _Property_DF6FBA39_Out_0, 0, _Combine_87F30693_RGBA_4, _Combine_87F30693_RGB_5, _Combine_87F30693_RG_6);
                        float _Property_E11AE7BB_Out_0 = _SnowThickness;
                        float _Property_57A4C6C2_Out_0 = _SnowSmoothnessRemapMax;
                        float _Property_EA71F713_Out_0 = _SnowAORemapMax;
                        float4 _Combine_AA812D25_RGBA_4;
                        float3 _Combine_AA812D25_RGB_5;
                        float2 _Combine_AA812D25_RG_6;
                        Unity_Combine_float(_Property_E11AE7BB_Out_0, _Property_57A4C6C2_Out_0, _Property_EA71F713_Out_0, 0, _Combine_AA812D25_RGBA_4, _Combine_AA812D25_RGB_5, _Combine_AA812D25_RG_6);
                        float3 _Lerp_30554DC2_Out_3;
                        Unity_Lerp_float3(_Combine_87F30693_RGB_5, _Combine_AA812D25_RGB_5, (_Lerp_35ABD04D_Out_3.xxx), _Lerp_30554DC2_Out_3);
                        float _Split_E307B1E0_R_1 = _Lerp_30554DC2_Out_3[0];
                        float _Split_E307B1E0_G_2 = _Lerp_30554DC2_Out_3[1];
                        float _Split_E307B1E0_B_3 = _Lerp_30554DC2_Out_3[2];
                        float _Split_E307B1E0_A_4 = 0;
                        float _Property_6D561E3B_Out_0 = _AlphaCutoff;
                        surface.Albedo = _Lerp_A5D643F2_Out_3;
                        surface.Normal = _NormalStrength_EDF1EB8B_Out_2;
                        surface.BentNormal = IN.TangentSpaceNormal;
                        surface.Thickness = _Split_E307B1E0_R_1;
                        surface.DiffusionProfileHash = _DiffusionProfileHash;
                        surface.CoatMask = 0;
                        surface.Emission = float3(0, 0, 0);
                        surface.Smoothness = _Split_E307B1E0_G_2;
                        surface.Occlusion = _Split_E307B1E0_B_3;
                        surface.Alpha = _SampleTexture2D_3E7E8460_A_7;
                        surface.AlphaClipThreshold = _Property_6D561E3B_Out_0;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        #if !defined(SHADER_STAGE_RAY_TRACING)
            // Vertex animation is not supported in the ray tracing context
            //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
            
            VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                output.ObjectSpaceTangent =          input.tangentOS;
                // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.ObjectSpacePosition =         input.positionOS;
                // output.WorldSpacePosition =          TransformObjectToWorld(input.positionOS);
                // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                // output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
                // output.uv0 =                         input.uv0;
                // output.uv1 =                         input.uv1;
                // output.uv2 =                         input.uv2;
                // output.uv3 =                         input.uv3;
                // output.VertexColor =                 input.color;
                // output.BoneWeights =                 input.weights;
                // output.BoneIndices =                 input.indices;
            
                return output;
            }
            
            AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
            {
                // build graph inputs
                VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
                // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
                vertexDescriptionInputs.TimeParameters = timeParameters;
            
                // evaluate vertex graph
                VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
            
                // copy graph output to the results
                input.positionOS = vertexDescription.VertexPosition;
                input.normalOS = vertexDescription.VertexNormal;
                input.tangentOS.xyz = vertexDescription.VertexTangent;
            
                return input;
            }
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
            //-------------------------------------------------------------------------------------
            
        #endif
        
        //-------------------------------------------------------------------------------------
            // TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
                FragInputs BuildFragInputs(VaryingsMeshToPS input)
                {
                    FragInputs output;
                    ZERO_INITIALIZE(FragInputs, output);
            
                    // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                    // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                    // to compute normals which are then passed on elsewhere to compute other values...
                    output.tangentToWorld = k_identity3x3;
                    output.positionSS = input.positionCS;       // input.positionCS is SV_Position
            
                    output.positionRWS = input.positionRWS;
                    output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                    output.texCoord0 = input.texCoord0;
                    // output.texCoord1 = input.texCoord1;
                    // output.texCoord2 = input.texCoord2;
                    // output.texCoord3 = input.texCoord3;
                    // output.color = input.color;
                    #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #elif SHADER_STAGE_FRAGMENT
                    output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                    #endif // SHADER_STAGE_FRAGMENT
            
                    return output;
                }
            #endif
                SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                    output.WorldSpaceNormal =            input.tangentToWorld[2].xyz;	// normal was already normalized in BuildTangentToWorld()
                    // output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
                    // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                    // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                    // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                    // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                    // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                    // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                    // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                    // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                    // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                    // output.WorldSpaceViewDirection =     normalize(viewWS);
                    // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                    // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                    // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                    // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                    // output.WorldSpacePosition =          input.positionRWS;
                    // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                    // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                    // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionRWS);
                    // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                    output.uv0 =                         input.texCoord0;
                    // output.uv1 =                         input.texCoord1;
                    // output.uv2 =                         input.texCoord2;
                    // output.uv3 =                         input.texCoord3;
                    // output.VertexColor =                 input.color;
                    // output.FaceSign =                    input.isFrontFace;
                    // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            
                    return output;
                }
            
            #if !defined(SHADER_STAGE_RAY_TRACING)
            
                // existing HDRP code uses the combined function to go directly from packed to frag inputs
                FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
                {
                    UNITY_SETUP_INSTANCE_ID(input);
                    VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                    return BuildFragInputs(unpacked);
                }
            #endif
            
            //-------------------------------------------------------------------------------------
            // END TEMPLATE INCLUDE : SharedCode.template.hlsl
            //-------------------------------------------------------------------------------------
            
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
                // however specularOcclusion can come from the graph, so need to be init here so it can be override.
                surfaceData.specularOcclusion = 1.0;
        
                // copy across graph values, if defined
                surfaceData.baseColor =                 surfaceDescription.Albedo;
                surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
                surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
                // surfaceData.specularOcclusion =         surfaceDescription.SpecularOcclusion;
                // surfaceData.metallic =                  surfaceDescription.Metallic;
                // surfaceData.subsurfaceMask =            surfaceDescription.SubsurfaceMask;
                surfaceData.thickness =                 surfaceDescription.Thickness;
                surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
                // surfaceData.specularColor =             surfaceDescription.Specular;
                surfaceData.coatMask =                  surfaceDescription.CoatMask;
                // surfaceData.anisotropy =                surfaceDescription.Anisotropy;
                // surfaceData.iridescenceMask =           surfaceDescription.IridescenceMask;
                // surfaceData.iridescenceThickness =      surfaceDescription.IridescenceThickness;
        
        #ifdef _HAS_REFRACTION
                if (_EnableSSRefraction)
                {
                    // surfaceData.ior =                       surfaceDescription.RefractionIndex;
                    // surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                    // surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
        #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
        #endif
        
                // These static material feature allow compile time optimization
                surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
        #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
        #endif
        #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
        #endif
        #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        #endif
                // surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
        
        #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
        #endif
        #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
        #endif
        
        #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                // normal delivered to master node
                float3 normalSrc = float3(0.0f, 0.0f, 1.0f);
                normalSrc = surfaceDescription.Normal;
        
                // compute world space normal
        #if _NORMAL_DROPOFF_TS
                GetNormalWS(fragInputs, normalSrc, surfaceData.normalWS, doubleSidedConstants);
        #elif _NORMAL_DROPOFF_OS
        		surfaceData.normalWS = TransformObjectToWorldNormal(normalSrc);
        #elif _NORMAL_DROPOFF_WS
        		surfaceData.normalWS = normalSrc;
        #endif
        
                surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
                // surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
        
        #if HAVE_DECALS
                if (_EnableDecals)
                {
                    // Both uses and modifies 'surfaceData.normalWS'.
                    DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, surfaceDescription.Alpha);
                    ApplyDecalToSurfaceData(decalSurfaceData, surfaceData);
                }
        #endif
        
                bentNormalWS = surfaceData.normalWS;
                // GetNormalWS(fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants);
        
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
        
                // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
                // If user provide bent normal then we process a better term
        #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
        #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
        #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
        #endif
        
        #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
        #endif
        
        #if defined(DEBUG_DISPLAY) && !defined(SHADER_STAGE_RAY_TRACING)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
        #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
        #endif
        
        #ifdef _DOUBLESIDED_ON
            float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
        #else
            float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
        #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
        #ifdef _ALPHATEST_ON
                GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPrepass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdDepthPostpass);
                // GENERIC_ALPHA_TEST(surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
        #endif
        
                // ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
        
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);
        
                // override sampleBakedGI:
                // builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
                // builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // builtinData.depthOffset = surfaceDescription.DepthOffset;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #else
                builtinData.distortion = float2(0.0, 0.0);
                builtinData.distortionBlur = 0.0;
        #endif
        
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassPathTracing.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
    }
    CustomEditor "UnityEditor.Rendering.HighDefinition.HDLitGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
