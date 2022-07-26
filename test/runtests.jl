using NonlinearSequences
using Test
using Aqua

@testset "NonlinearSequences.jl" begin
    @testset "logspace" begin include("logspace.test.jl") end
    @testset "octspace" begin include("octspace.test.jl") end
    @testset "decspace" begin include("decspace.test.jl") end
    @testset "powspace" begin include("powspace.test.jl") end
    @testset "Aqua.jl" begin Aqua.test_all(NonlinearSequences) end
end
