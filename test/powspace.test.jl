@testset "powspace Main API" begin
    # powspace(start, stop, power, length)
    @test powspace(0, 1, 2, 3) == [0., .25, 1.]
    @test powspace(0, 1, 1/2, 3) == [0., sqrt(.5), 1.]
end