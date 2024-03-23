#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\SSAO-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Shader;
sampler Shader_Sampler;
float g_SSAOScreenWidth;
float g_SSAOScreenHeight;
float2 g_QAndZnQ;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void SSAO(sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    float ScreenSizeW,
    float ScreenSizeH,
    float3 NV40,
    float2 QAndZnQ,
    float InvRange,
    out float4 Output)
{
    static const float3 Kernel [8] =
    {
        float3 (-0.276147, -0.629537, 0.726241),
        float3 (0.340907, -0.494679, 0.799422),
        float3 (-0.494679, -0.340907, 0.799422),
        float3 (0.320201, -0.608652, 0.725957),
        float3 (-0.340907, 0.494679, 0.799422),
        float3 (0.494679, 0.340907, 0.799422),
        float3 (-0.66473, -0.176915, 0.725834),
        float3 (-0.000384922, -0.000313641, 1.0)
    };

    float3 Radius;
    Radius.x = 1.5 * 0.03;
    Radius.y = 1.5 * 0.03 * (9.0 / 16.0);
    Radius.z = 1.5 * 0.03;

#ifdef D3D10
    float Depth = Texture.Sample (Sampler, TexCoord);
#else
    float Depth = tex2D (Texture, TexCoord);
#endif
    Depth = QAndZnQ.y / (QAndZnQ.x - Depth);

    float2 TSRadius = Radius.xy * 0.25;
    float DSRadius = 1.0 / (Radius.z * Depth);

    Output = 1.0;
    float4 Access = 0.0;
    float4 KernelZs = 0.0;

    for (int i = 0; i < 1; ++i)
    {
        float4 SampleDepth;
        float4 KernelZ;
#ifdef D3D10
        SampleDepth.x = Texture.Sample (Sampler, TexCoord + Kernel [i*4+0].xy * TSRadius);
        SampleDepth.y = Texture.Sample (Sampler, TexCoord + Kernel [i*4+1].xy * TSRadius);
        SampleDepth.z = Texture.Sample (Sampler, TexCoord + Kernel [i*4+2].xy * TSRadius);
        SampleDepth.w = Texture.Sample (Sampler, TexCoord + Kernel [i*4+3].xy * TSRadius);
#else
        SampleDepth.x = tex2D (Texture, TexCoord + Kernel [i*4+0].xy * TSRadius);
        SampleDepth.y = tex2D (Texture, TexCoord + Kernel [i*4+1].xy * TSRadius);
        SampleDepth.z = tex2D (Texture, TexCoord + Kernel [i*4+2].xy * TSRadius);
        SampleDepth.w = tex2D (Texture, TexCoord + Kernel [i*4+3].xy * TSRadius);
#endif
        SampleDepth = QAndZnQ.y / (QAndZnQ.x - SampleDepth);
        KernelZ.x = Kernel [i*4+0].z;
        KernelZ.y = Kernel [i*4+1].z;
        KernelZ.z = Kernel [i*4+2].z;
        KernelZ.w = Kernel [i*4+3].z;

        float4 TransformedDepth = (SampleDepth - Depth) * DSRadius;
        float4 Obscurance = max (min (KernelZ, TransformedDepth) + KernelZ, 0.0);

        float4 Trans = saturate (0.4 * (TransformedDepth + KernelZ) + 1.0);
        float4 FadeOut = Trans * Trans;

        Access += lerp (1.5 * KernelZ, Obscurance, FadeOut);
        KernelZs += KernelZ;
    }

    Output.xyz = min (Output.xyz, dot (Access / 4.0, 1.0 / KernelZs));

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
    SSAO(Shader, Shader_Sampler, In.UVSet0, g_SSAOScreenWidth, 
        g_SSAOScreenHeight, float3(0.0, 0.0, 0.0), g_QAndZnQ, float(1.0 / 3.0), 
        Out.Color);

    return Out;
}

