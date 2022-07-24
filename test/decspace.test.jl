@testset "decspace Main API" begin
    # decspace(start, stop, step)
    @test decspace(20, 20e3, 1/24) == logspace(20, 20e3, step=1/24, base=10)
    # decspace(start, stop, step; adjust_step)
    @test decspace(20, 20e3, 1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=10, adjust_step=true)
    # decspace(start, stop; step adjust_step)
    @test decspace(20, 20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=10, adjust_step=true)
    # decspace(start; stop, step, adjust_step)
    @test decspace(20, stop=20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=10, adjust_step=true)
    # decspace(; start, stop, step, adjust_step)
    @test decspace(start=20, stop=20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=10, adjust_step=true)
end

@testset "decspace Additional APIs with start or stop missing" begin
    # Additional APIs with start or stop missing
    # decspace(start; length, step)
    @test decspace(20, length=300, step=1/24) == 
        logspace(20, length=300, step=1/24, base=10)
    # decspace(; start, length, step)
    @test decspace(start=20, length=300, step=1/24) == 
        logspace(20, length=300, step=1/24, base=10)
    # decspace(; stop, length, step)
    @test decspace(stop=20e3, length=300, step=1/24) == 
        logspace(stop=20e3, length=300, step=1/24, base=10)
end