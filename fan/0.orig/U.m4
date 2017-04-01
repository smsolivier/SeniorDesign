/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  4.x                                   |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       volVectorField;
    location    "0";
    object      U;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

changecom(//)
changequote([,]) dnl>

define(calc, [esyscmd(perl -e 'use Math::Trig; print ($1)')]) dnl>
changequote()

define(Uinlet, 20) dnl>

dimensions      [0 1 -1 0 0 0 0];

internalField   uniform (0 0 0);

boundaryField
{
    defaultFaces
    {
        type empty; 
    }
    
    outlet
    {
        type inletOutlet; 
        inletValue uniform (0 0 0); 
        value uniform (0 0 0); 
    }

    inlet
    {
        type pressureInletOutletVelocity; 
        value uniform (0 0 0); 
    }

    sg
    {
        type            noSlip;
    }

    shroud
    {
        type noSlip; 
    }

    leftWedge
    {
        type wedge; 
    }

    rightWedge
    {
        type wedge; 
    }
}


// ************************************************************************* //
