@testset "octspace with points_per_octave=2" begin
    # Main API
    # octspace(start, stop, step)
    @test octspace(20, 20e3, 1/24) == logspace(20, 20e3, step=1/24, base=2)
    # octspace(start, stop, step; adjust_step)
    @test octspace(20, 20e3, 1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=2, adjust_step=true)
    # octspace(start, stop; step adjust_step)
    @test octspace(20, 20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=2, adjust_step=true)
    # octspace(start; stop, step, adjust_step)
    @test octspace(20, stop=20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=2, adjust_step=true)
    # octspace(; start, stop, step, adjust_step)
    @test octspace(start=20, stop=20e3, step=1/24, adjust_step=true) == 
        logspace(20, 20e3, step=1/24, base=2, adjust_step=true)

    # Additional APIs with start or stop missing
    # octspace(start; length, step)
    @test octspace(20, length=300, step=1/24) == 
        logspace(20, length=300, step=1/24, base=2)
    # octspace(; start, length, step)
    @test octspace(start=20, length=300, step=1/24) == 
        logspace(20, length=300, step=1/24, base=2)
    # octspace(; stop, length, step)
    @test octspace(stop=20e3, length=300, step=1/24) == 
        logspace(stop=20e3, length=300, step=1/24, base=2)

    # TODO
    # test whether warnings and errors are useful for octspace
    # Example:
    # octspace(20, 20e3) # "provide step and base" is not wrong, but base is provided
    # -> test for step and base separately?

end