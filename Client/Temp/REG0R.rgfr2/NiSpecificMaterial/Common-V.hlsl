#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\Common-V.hlsl"
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

void Common(float4x4 Proj,
    float3 Input,
    float2 TexCoord,
    out float4 Output,
    out float2 TexCoord0)
{
    float2 ScreenCenter = float2 (2.0, -2.0);
    float2 ScreenOffset = float2 (-1.0, 1.0);
    float2 ScreenCoord = float2 (Proj [3][0], Proj [3][1]);
    Output = float4 (Input.xy * ScreenCenter + ScreenOffset + ScreenCoord, 1.0, 1.0);
    TexCoord0 = TexCoord;

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
    float2 UVSet0 : TEXCOORD0;

};

//---------------------------------------------------------------------------
// Main():
//---------------------------------------------------------------------------

Output Main(Input In)
{
    Output Out;
	// Function call #0
    Common(g_Proj, In.Position, In.UVSet, Out.PosProjected, Out.UVSet0);

    return Out;
}

