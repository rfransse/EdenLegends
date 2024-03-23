#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\DepthOfField-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
sampler2D Shader;
sampler Shader_Sampler;
float2 g_QAndZnQ;
float g_DOFDistance;
float g_DOFRange;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void DepthOfField(sampler2D Texture,
    sampler Sampler,
    sampler2D DepthTexture,
    sampler DepthSampler,
    float2 TexCoord,
    float3 NV40,
    float2 QAndZnQ,
    float DOFDistance,
    float DOFRange,
    out float4 Output)
{
    float Depth;
    if (NV40.x != 0.0)
    {
#ifdef D3D10
        float3 RAWZ = DepthTexture.Sample (DepthSampler, TexCoord).arg;
#else
        float3 RAWZ = tex2D (DepthTexture, TexCoord).arg;
#endif
        RAWZ = floor (RAWZ * 255.0 + 0.5);
        Depth = dot (RAWZ, NV40 / 255.0);
    }
    else
    {
#ifdef D3D10
        Depth = DepthTexture.Sample (DepthSampler, TexCoord);
#else
        Depth = tex2D (DepthTexture, TexCoord);
#endif
    }

    float Blur = 0.0;
    {
        Depth = QAndZnQ.y / (QAndZnQ.x - Depth);
        Blur = (Depth - DOFDistance) * (1.0 / DOFRange);
    }

#ifdef D3D10
    float3 BlurColor = Texture.Sample (Sampler, TexCoord).rgb;
#else
    float3 BlurColor = tex2D (Texture, TexCoord).rgb;
#endif
    Output = float4 (BlurColor, Blur);

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
    DepthOfField(Base, Base_Sampler, Shader, Shader_Sampler, In.UVSet0, 
        float3(0.0, 0.0, 0.0), g_QAndZnQ, g_DOFDistance, g_DOFRange, Out.Color);

    return Out;
}

