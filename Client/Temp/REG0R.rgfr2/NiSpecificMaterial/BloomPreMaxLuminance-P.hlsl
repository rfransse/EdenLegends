#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BloomPreMaxLuminance-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
float4x4 g_Proj;
sampler2D Shader;
sampler Shader_Sampler;
sampler2D Shader1;
sampler Shader1_Sampler;
float g_BloomThreshold;
float g_BloomRatio;
float g_BloomExposure;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BloomPreMaxLuminance(sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    float4x4 Projection,
    sampler2D BlurTexture,
    sampler BlurSampler,
    sampler2D LumaTexture,
    sampler LumaSampler,
    float3 LumaTable,
    float Threshold,
    float Ratio,
    float Exposure,
    out float4 Output)
{
    float Width = Projection [3][0] * 0.5;
    float Height = Projection [3][1] * 0.5;
#ifdef D3D10
    float3 SumColor
        = Texture.Sample (Sampler, TexCoord + float2 (-Width, -Height))
        + Texture.Sample (Sampler, TexCoord + float2 (-Width,  Height))
        + Texture.Sample (Sampler, TexCoord + float2 ( Width, -Height))
        + Texture.Sample (Sampler, TexCoord + float2 ( Width,  Height));
    float3 BlurColor = BlurTexture.Sample (BlurSampler, TexCoord);
    float MaxLuma = LumaTexture.Sample (LumaSampler, TexCoord).g;
#else
    float3 SumColor
        = tex2D (Texture, TexCoord + float2 (-Width, -Height))
        + tex2D (Texture, TexCoord + float2 (-Width,  Height))
        + tex2D (Texture, TexCoord + float2 ( Width, -Height))
        + tex2D (Texture, TexCoord + float2 ( Width,  Height));
    float3 BlurColor = tex2D (BlurTexture, TexCoord);
    float MaxLuma = tex2D (LumaTexture, TexCoord).g;
#endif
    float3 AvgColor = SumColor / 4.0;
    float3 Tone = AvgColor + BlurColor * Ratio;
    Tone = Tone * Exposure * (Exposure / MaxLuma * 2.0 + 1.0) / (Exposure + 1.0);
    Tone = dot (Tone, LumaTable) / (1.0 + Ratio * (1.0 - Threshold));
    Output = float4 (Tone, 1.0);

}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Input:
//---------------------------------------------------------------------------

struct Input
{
    float4 PosProjected : POSITION0;
    float2 UVSet0 : TEXCOORD0;

};

//---------------------------------------------------------------------------
// Output:
//---------------------------------------------------------------------------

struct Output
{
    float4 Color : COLOR0;

};

//---------------------------------------------------------------------------
// Main():
//---------------------------------------------------------------------------

Output Main(Input In)
{
    Output Out;
	// Function call #0
    BloomPreMaxLuminance(Base, Base_Sampler, In.UVSet0, g_Proj, Shader, 
        Shader_Sampler, Shader1, Shader1_Sampler, 
        float3(0.212656, 0.715158, 0.072186), g_BloomThreshold, g_BloomRatio, 
        g_BloomExposure, Out.Color);

    return Out;
}

