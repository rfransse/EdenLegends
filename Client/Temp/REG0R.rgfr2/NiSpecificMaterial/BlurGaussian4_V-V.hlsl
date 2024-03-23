#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BlurGaussian4_V-V.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

float4x4 g_Proj;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BlurGaussian4VSV(float4x4 Proj,
    float3 Input,
    float2 TexCoord,
    float4 Mask,
    float Offset0,
    float Offset1,
    out float4 Output,
    out float4 TexCoord0,
    out float4 TexCoord1)
{
    float2 ScreenCenter = float2 (2.0, -2.0);
    float2 ScreenOffset = float2 (-1.0, 1.0);
    float2 ScreenCoord = float2 (Proj [3][0], Proj [3][1]);
    Output = float4 (Input.xy * ScreenCenter + ScreenOffset + ScreenCoord, 1.0, 1.0);
    float4 Blur = ScreenCoord.xyyx * Mask;
    TexCoord0 = TexCoord.xyyx + Blur * Offset0;
    TexCoord1 = TexCoord.xyyx + Blur * Offset1;

}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Input:
//---------------------------------------------------------------------------

struct Input
{
    float3 Position : POSITION0;
    float2 UVSet : TEXCOORD0;

};

//---------------------------------------------------------------------------
// Output:
//---------------------------------------------------------------------------

struct Output
{
    float4 PosProjected : POSITION0;
    float4 UVSet0 : TEXCOORD0;
    float4 UVSet1 : TEXCOORD1;

};

//---------------------------------------------------------------------------
// Main():
//---------------------------------------------------------------------------

Output Main(Input In)
{
    Output Out;
	// Function call #0
    BlurGaussian4VSV(g_Proj, In.Position, In.UVSet, float4(0.0, -1.0, 1.0, 0.0), 
        float(0.5), float(1.5), Out.PosProjected, Out.UVSet0, Out.UVSet1);

    return Out;
}

