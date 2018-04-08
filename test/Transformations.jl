include("../model/SensorModel.jl")
using Base.Test

let cartesian_point = [4 2]

    homogeneous_point = cart2hom(cartesian_point)

    @test homogeneous_point[1] ≈ 4
    @test homogeneous_point[2] ≈ 2
    @test homogeneous_point[3] ≈ 1
end

let homogeneous_point = [4 2 1]

    cartesian_point = hom2cart(homogeneous_point)

    @test cartesian_point[1] ≈ 4
    @test cartesian_point[2] ≈ 2
end

let homogeneous_point = [4 2 0.5]

    cartesian_point = hom2cart(homogeneous_point)

    @test cartesian_point[1] ≈ 8
    @test cartesian_point[2] ≈ 4
end

let homogeneous_point = [4; 2; 0.5]

    cartesian_point = hom2cart(homogeneous_point)

    @test cartesian_point[1] ≈ 8
    @test cartesian_point[2] ≈ 4
end

let homogeneous_point = [4 2 0]

    cartesian_point = hom2cart(homogeneous_point)

    @test cartesian_point[1] ≈ Inf
    @test cartesian_point[2] ≈ Inf
end

let cartesian_point = [1.5 0.5]
    rotation = π/2

    homogeneous_point = cart2hom(cartesian_point)
    rotated_point = rotate(rotation) * transpose(homogeneous_point)
    rotated_cartesian_point = hom2cart(rotated_point)

    @test rotated_cartesian_point[1] ≈ -0.5
    @test rotated_cartesian_point[2] ≈ 1.5
end

let cartesian_point = [1.5 0.5]
    translation_x = 3
    translation_y = -4

    homogeneous_point = cart2hom(cartesian_point)
    translated_point =  translate(translation_x, translation_y) * transpose(homogeneous_point)
    translated_cartesian_point = hom2cart(translated_point)

    @test translated_cartesian_point[1] ≈ 4.5
    @test translated_cartesian_point[2] ≈ -3.5
end

let cartesian_point = [1.5 0.5]
    rotation = π/2
    translation_x = 3

    homogeneous_point = cart2hom(cartesian_point)
    first_rotated_then_translated_point = translate(translation_x, 0) * rotate(rotation) * transpose(homogeneous_point)
    transformed_point = hom2cart(first_rotated_then_translated_point)

    @test transformed_point[1] ≈ 2.5
    @test transformed_point[2] ≈ 1.5
end
