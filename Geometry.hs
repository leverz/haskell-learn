module Geometry
(
--  sphere: 球体
    sphereVolume,
    sphereArea,
--  cube: 立方体
    cubeVolume,
    cubeArea,
--  cuboid: 长方体
    cuboidArea,
    cuboidVolume
) where
    sphereVolume :: Float -> Float
    sphereVolume radius = (4.0 / 3.0) * pi * (radius ^ 3)

    sphereArea :: Float -> Float
    sphereArea radius = 4 * pi * (radius ^ 2)

    cubeVolume :: Float -> Float
    cubeVolume side = cuboidVolume side side side

    cubeArea :: Float -> Float
    cubeArea side = cuboidArea side side side

    cuboidVolume :: Float -> Float -> Float -> Float
    cuboidVolume a b c = rectArea a b * c

    cuboidArea :: Float -> Float -> Float -> Float
    cuboidArea a b c = rectArea a b * 2 + rectArea a c * 2 + rectArea b c * 2

-- 矩形面积
    rectArea :: Float -> Float -> Float
    rectArea a b = a * b