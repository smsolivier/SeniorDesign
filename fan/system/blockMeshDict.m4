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
    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

convertToMeters 1;

changecom(//)changequote([,]) dnl>
define(calc, [esyscmd(perl -e 'use Math::Trig; print ($1)')]) dnl>

define(R, 2)
define(delta, .1) 
define(theta, calc(deg2rad(3)))
define(H, 6)

vertices
(
    (calc(-R*sin(theta/2)) calc(R*cos(theta/2)) 0) // 0
    (calc(R*sin(theta/2)) calc(R*cos(theta/2)) 0) // 1 
    (calc((R+delta)*sin(theta/2)) calc((R+delta)*cos(theta/2)) 0) // 2
    (calc(-(R+delta)*sin(theta/2)) calc((R+delta)*cos(theta/2)) 0) // 3

    (calc(-R*sin(theta/2)) calc(R*cos(theta/2)) H) // 4
    (calc(R*sin(theta/2)) calc(R*cos(theta/2)) H) // 5
    (calc((R+delta)*sin(theta/2)) calc((R+delta)*cos(theta/2)) H) // 6
    (calc(-(R+delta)*sin(theta/2)) calc((R+delta)*cos(theta/2)) H) // 7

);

edges
(
    arc 0 1 (0 R 0) 
    arc 4 5 (0 R H)

    arc 3 2 (0 calc(R+delta) 0)
    arc 7 6 (0 calc(R+delta) H)
);

blocks
(
    hex (0 1 2 3 4 5 6 7) (1 40 450) simpleGrading (
        (
            1
        )
        (
            1
            // (.1 .1 5)
            // (.8 .8 1)
            // (.1 .1 .2)
        )
        (
            5
        )
    )
);

boundary
(
    sg 
    {
        type wall; 
        faces
        (
            (0 1 4 5)
        ); 
    }

    shroud
    {
        type wall; 
        faces
        (
            (3 2 6 7)
        ); 
    }

    inlet
    {
        type patch; 
        faces
        (
            (0 1 2 3)
        );
    }

    outlet
    {
        type patch; 
        faces
        (
            (4 5 6 7)
        ); 
    }

    rightWedge
    {
        type wedge; 
        faces
        (
            (1 5 2 6)
        ); 
    }

    leftWedge
    {
        type wedge; 
        faces
        (
            (0 4 7 3)
        );
    }
);

mergePatchPairs
(
);
