Shader "Hidden/Custom/Outline"
{
    Properties
    {
        //Цвет вводится пользователем
        _MainColor("Main Color", Color) = (1,1,1,1)
    }

        SubShader
    {
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #pragma enable_cbuffer

            float4 _MainColor;
            //--------------------------------------------------------------------------------------
            // Переменные шейдера
            //--------------------------------------------------------------------------------------
            cbuffer ConstantBuffer : register(b0)
            {
                float4x4 ViewProjectionMatrix;
                float4x4 WorldMatrix;
            }

            struct VertexInput
            {
                float3 Position : POSITION;
                float2 Tex : TEXCOORD;
            };

            struct VertexOutput
            {
                float4 Position : SV_POSITION;
                float2 Tex : TEXCOORD;
            };

            struct PixelInput
            {
                float4 Position : SV_POSITION;
                float2 Tex : TEXCOORD;
            };

            //--------------------------------------------------------------------------------------
            // Функции шейдера
            //--------------------------------------------------------------------------------------

            // Функция для вычисления позиции
            VertexOutput Vert(VertexInput input)
            {
                VertexOutput output;
                output.Position = mul(mul(float4(input.Position, 1.0), WorldMatrix), ViewProjectionMatrix);
                output.Tex = input.Tex;
                return output;
            }

            // Функция для вычисления цвета пикселя
            float4 Frag(PixelInput input) : SV_TARGET
            {
                return _MainColor;
            }

            /*// Vertex Shader
            struct VertexInput
            {
                float4 position : POSITION;
            };

            struct VertexOutput
            {
                float4 position : SV_POSITION;
            };

            VertexOutput VertDefault(VertexInput input)
            {
                VertexOutput output;
                output.position = input.position;
                return output;
            }

            float4 _MainColor;

            // Pixel Shader
            struct PixelInput
            {
                float4 position : SV_POSITION;
            };

            float4 Frag(PixelInput input) : SV_TARGET
            {
                return _MainColor; // Основной цвет
            }*/

            ENDHLSL
        }
    }
}