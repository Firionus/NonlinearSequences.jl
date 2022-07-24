using NonuniformSmoothing1D
using Test
using Aqua

@testset "NonuniformSmoothing1D.jl" begin
    # Write your tests here.

    @testset "API Ideas" begin
        @testset "logspace with start, stop and length" begin
            # logspace(start, stop, length)
            y = logspace(20, 20e3, 3)
            @test length(y) == 3
            @test y[1] ≈ 20 # rounding errors...
            @test y[2] == exp((log(20)+log(20e3))/2) # 632.5
            @test y[end] ≈ 20e3 # rounding errors...
            # logspace(start, stop; length)
            @test y == logspace(20, 20e3, length=3)
            # logspace(start; stop, length)
            @test y == logspace(20, stop=20e3, length=3)
            # logspace(; start, stop, length)
            @test y == logspace(start=20, stop=20e3, length=3)
        end

        @testset "logspace with start, stop, step and base" begin
            # logspace(start, stop; step, base)
            y = logspace(1, 2, step=1/2, base=2)
            @test length(y) == 3
            @test y[1] == 1
            @test y[2] ≈ 2^.5
            @test y[end] == 2
            # logspace(start; stop, step, base)
            @test y == logspace(1, stop=2, step=1/2, base=2)
            # logspace(; start, stop, step, base)
            @test y == logspace(start=1, stop=2, step=1/2, base=2)
        end

        @testset "logspace stop is recessive to step by default" begin
            # if step/base and start/stop are incompatible, obey start and step/base and disobey stop
            y = logspace(1, 1.99, step=1/2, base=2)
            @test length(y) == 2
            @test y[1] == 1
            @test y[end] ≈ 2^.5 # 1.4, smaller than stop=1.99

            # option to adjust this behavior
            z = logspace(1, 1.99, step=1/2, base=2, adjust_step=true)
            @test length(z) == 2
            @test z[1] == 1
            @test z[end] == 1.99
            # other calling variants
            @test z == logspace(start=1, stop=1.99, step=1/2, base=2, adjust_step=true)
            @test z == logspace(1, stop=1.99, step=1/2, base=2, adjust_step=true)
        end

        @testset "logspace with start, step, base and length" begin
            # logspace(start; step, base, length)
            y = logspace(1, step=1/2, base=2, length=3)
            @test y[1] == 1
            @test y[2] ≈ 2^.5
            @test y[end] == 2
            # logspace(; start, step, base, length)
            @test y == logspace(start=1, step=1/2, base=2, length=3)
        end

        @testset "logspace with stop, step, base and length" begin
            # logspace(; stop, step, base, length)
            y = logspace(stop=2, step=1/2, base=2, length=3)
            @test y[1] == 1
            @test y[2] ≈ 2^.5
            @test y[end] == 2
        end

        @testset "logspace errors with inappropriate arguments" begin
            @test_logs (:warn, "step and base are ignored when start, stop and length are given") (
                # length is dominant over step/base
                @test all(logspace(start=1, stop=2, step=1/100, base=2, length=3) .≈ [1, 2^.5, 2])
            )
            @test_logs (:warn, "step and base are ignored when start, stop and length are given"
                ) logspace(start=1, stop=2, step=1/2, length=3)
            @test_logs (:warn, "step and base are ignored when start, stop and length are given"
                ) logspace(start=1, stop=2, base=2, length=3)
            @test_logs (:warn, "adjust_step is ignored when length is given"
                ) logspace(start=1, stop=2, length=3, adjust_step=true)
            @test_logs (
                :warn, "step and base are ignored when start, stop and length are given") (
                :warn, "adjust_step is ignored when length is given"
                ) logspace(start=1, stop=2, step=1/2, base=2, length=3, adjust_step=true)

            @test_logs (:warn, "adjust_step is ignored when length is given"
                ) logspace(start=1, length=3, step=1/2, base=2, adjust_step=true)
            @test_logs (:warn, "adjust_step is ignored when length is given"
                ) logspace(stop=2, length=3, step=1/2, base=2, adjust_step=true)


            @test_throws ArgumentError logspace(start=1, stop=2, step=1/2)
            @test_throws ArgumentError logspace(start=1, stop=2, base=2)

            @test_throws ArgumentError logspace(1, adjust_step=true)
            @test_throws ArgumentError logspace(start=1, adjust_step=true)

            @test_throws ArgumentError logspace(start=1, base=2, adjust_step=true)
            @test_throws ArgumentError logspace(start=1, base=2)
            @test_throws ArgumentError logspace(1, base=2)
            @test_throws ArgumentError logspace(start=1, step=1/2, adjust_step=true)
            @test_throws ArgumentError logspace(start=1, step=1/2)
            @test_throws ArgumentError logspace(1, step=1/2)

            @test_throws ArgumentError logspace(start=1)
            @test_throws ArgumentError logspace(1)

            @test_throws ArgumentError logspace(stop=1)
            @test_throws ArgumentError logspace(length=1)
            @test_throws ArgumentError logspace(step=1)
            @test_throws ArgumentError logspace(base=1)
            @test_throws ArgumentError logspace(adjust_step=true)

            @test_throws ArgumentError logspace(base=2, step=1/2)

            @test_throws ArgumentError logspace(1, length=2)
            @test_throws ArgumentError logspace(1, adjust_step=true)

            @test_throws ArgumentError logspace(1,2)
            @test_throws ArgumentError logspace(start=1, stop=2)

            @test_throws ArgumentError logspace(1,2, adjust_step=true)

            @test_throws ArgumentError logspace(start = 1, base = 2)

            @test_throws ArgumentError logspace(adjust_step=3, step=1/2, start=3, base=4)

            @test_throws ArgumentError logspace(adjust_step=nothing)
           
            # define positional parameter again in kwargs 
            @test_throws MethodError logspace(1, 2, length=3, start=.5)
            @test_throws MethodError logspace(1, stop=2, length=3, start=.5)

            # invalid kwarg
            @test_throws MethodError logspace(start=1, stop=2, length=3, unknown_kwarg=1)
            @test_throws MethodError logspace(1, stop=2, length=3, unknown_kwarg=1)
            @test_throws MethodError logspace(1, 2, length=3, unknown_kwarg=1)
            
        end

        @testset "logspace also produces decreasing values" begin
            @test all(logspace(2, 1, 3) .≈ [2, 2^.5, 1])
            @test all(logspace(2, 1, step=-1/2, base=2) .≈ [2, 2^.5, 1])
            @test all(logspace(2, length=3, step=-1/2, base=2) .≈ [2, 2^.5, 1])
            @test all(logspace(stop=1, length=3, step=-1/2, base=2) .≈ [2, 2^.5, 1])
        end

        # TODO enable later
        #=
        # TODO add octspace and decspace tests like for logspace

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



        @test length(logspace(20, 20e3, 200)) == 200
        logspace()

        @test logspace(20, 20e3, step=1) == logspace(20, stop=20e3, step=1) == logspace(start=20, stop=20e3, step=1)
        @test octspace(1, 10^3, step=1/10) == octspace(1, stop=10^3, step=1/10) == octspace(start=1, stop=10^3, step=1/10)
        @test decspace(1, 10^3, step=1/10) == decspace(1, stop=10^3, step=1/10) == decspace(start=1, stop=10^3, step=1/10)

        @test octspace(20, 20e3, step=1/24) == logspace(20, 20e3, step=1/24, base=2)
        octspace(20, 20e3, length=256)
        @test decspace(10^0, 10^3, step=1/20) == logspace(10^0, 10^3, step=1/20, base=10)
        @test length(decspace(10^0, 10^3, step=1/20)) == 20*3
        @test decspace(10^0, 10^3, step=1/20) == decspace(10^0, 10^3, length=20*3)
        

        =#
    end

    @testset "Aqua.jl" begin
        Aqua.test_all(NonuniformSmoothing1D)
    end

    @testset "Performance Examples" begin
        @test all(
            logspace(1, 2, 101) .≈
            logspace(1, 2, step=1/100, base=2) .≈
            logspace(1, length=101, step=1/100, base=2) .≈
            logspace(stop=2, length=101, step=1/100, base=2)
        )
        # TODO
        # options without start and step are about 30 % slower
    end
end
