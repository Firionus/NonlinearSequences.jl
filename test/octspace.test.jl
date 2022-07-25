@testset "octspace Main API" begin
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
end

@testset "octspace Additional APIs with start or stop missing" begin
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
    # octspace(start, stop; length) # no useless warnings
    @test_logs @test octspace(20, 20e3, length=200) == logspace(20, 20e3, 200)
    # octspace(start; stop, length) # no useless warnings
    @test_logs @test octspace(20, stop=20e3, length=200) == logspace(20, 20e3, 200)
    # octspace(;start, stop, length) # no useless warnings
    @test_logs @test octspace(start=20, stop=20e3, length=200) == logspace(20, 20e3, 200)
end

@testset "octspace Errors" begin
    try
        octspace(20, 20e3)
    catch err
        @test typeof(err) == ArgumentError
        @test occursin("step", err.msg)
        @test !occursin("base", err.msg) # don't tell users of octspace to provide base
    end

    try
        octspace(start=1, step=1/24)
    catch err
        @test typeof(err) == ArgumentError
        @test occursin("stop", err.msg)
        @test occursin("length", err.msg)
        @test !occursin("base", err.msg)
    end

    try
        octspace(step=1/24)
    catch err
        @test typeof(err) == ArgumentError
        @test !occursin("base", err.msg)
    end

    # referencing `base` here is a bit strange, but it's probably not a big issue
    @test_logs (:warn, "step and base are ignored when start, stop and length are given") (
        # length is dominant over step/base
        @test all(octspace(start=1, stop=2, step=1/100, length=3) .≈ [1, 2^.5, 2])
    )

    @test_logs (:warn, "adjust_step is ignored when length is given") (
        @test octspace(20, length=300, step=1/24, adjust_step=true) == 
        logspace(20, length=300, step=1/24, base=2)
    )

    @test_logs (:warn,) octspace(20, 20e3, length=4, adjust_step=true)
end