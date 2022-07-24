@testset "octspace with points_per_octave=2" begin
    # octspace(start, stop, points_per_octave)
    y = octspace(1, 2, 2)
    @test length(y) == 3
    @test y[1] == 1
    @test y[2] == 2^.5
    @test y[end] == 2
    # octspace(start; stop, points_per_octave)
    @test y == octspace(1, stop=2, points_per_octave=2)
    # octspace(; start, stop, points_per_octave)
    @test y == octspace(start=1, stop=2, points_per_octave=2)

    z = octspace(1, 1.99, 2)
    @test length(z) == 2
    @test z[1] == 1
    @test z[2] == 2^.5
    
    @test length(octspace(1, .99, 2)) == 2
end