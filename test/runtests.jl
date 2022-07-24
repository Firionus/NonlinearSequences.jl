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
            @test y[end] == 2^.5 # 1.4, smaller than stop=1.99

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
            @test y[2] == 2^.5
            @test y[end] == 2
            # logspace(; start, step, base, length)
            @test y == logspace(start=1, step=1/2, base=2, length=3)
        end

        @testset "logspace with stop, step, base and length" begin
            # logspace(; stop, step, base, length)
            y = logspace(stop=2, step=1/2, base=2, length=3)
            @test y[1] == 1
            @test y[2] == 2^.5
            @test y[end] == 2
        end

        @testset "logspace errors with inappropriate arguments" begin
            # length is dominant
            @test_logs (:warn, "step, base and adjust_step are ignored when length is given"
                ) logspace(start=1, stop=2, step=1/2, base=2, length=3)
            @test_logs (:warn, "step, base and adjust_step are ignored when length is given"
                ) logspace(start=1, stop=2, step=1/2, length=3)
            @test_logs (:warn, "step, base and adjust_step are ignored when length is given"
                ) logspace(start=1, stop=2, base=2, length=3)
            @test_logs (:warn, "step, base and adjust_step are ignored when length is given"
                ) logspace(start=1, stop=2, length=3, adjust_step=true)

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

            logspace(stop=2, length=3, step=1/2, base=2, adjust_step=true)

            # TODO what if stop <= start?
        end

        @testset "No method method ambiguities" begin
            @test detect_ambiguities(NonuniformSmoothing1D)|>isempty
        end

        # TODO make these go away
        #=
julia> detect_ambiguities(NonuniformSmoothing1D)
6-element Vector{Tuple{Method, Method}}:
 (_logspace(start, stop, length, step::Nothing, base::Nothing, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:34, _logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:41)
 (_logspace(start, stop::Nothing, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:39, _logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:41)
 (_logspace(start, stop, length::Nothing, step, base, adjust_step) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:37, _logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:41)
 (_logspace(start, stop::Nothing, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:39, _logspace(start::Nothing, stop::Nothing, length, step, base, adjust_step) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:78)
 (_logspace(start, stop, length::Nothing, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:36, _logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:41)
 (_logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:41, _logspace(start::Nothing, stop::Nothing, length, step, base, adjust_step) in NonuniformSmoothing1D at /home/johannes/.julia/dev/NonuniformSmoothing1D/src/NonuniformSmoothing1D.jl:78)
        =#

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

    # TODO enable later
    #=
    @testset "Aqua.jl" begin
        Aqua.test_all(NonuniformSmoothing1D)
    end
    =#

    # TODO: performance problems
    #=
    julia> @benchmark logspace(1, 2, step=1/100, base=2)
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   9.363 μs … 47.548 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     10.126 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   11.219 μs ±  2.564 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▄█▇▅▃▄▅▅▄▃▂▃▃▃▃▄▂▂▃▁▁▂▂▃▁                                   ▂
  ███████████████████████████▇████▇▇▆▆▅▅▄▆▆▇▆▆▇▆▆▇▆▅▆▆▆▄▄▄▄▂▅ █
  9.36 μs      Histogram: log(frequency) by time      21.4 μs <

 Memory estimate: 896 bytes, allocs estimate: 1.

julia> @benchmark logspace(1, length=100, step=1/100, base=2)
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   9.302 μs … 46.089 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     10.175 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   11.142 μs ±  2.499 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▄█▆▅▄▃▅▅▄▄▂▂▁▃▄▃▃▂▃▁▁▃▁▁▂▁                                  ▂
  █████████████████████████████▇█▇█▇██▇▇▆▇▆▇▆▆▆▆▄▅▅▄▅▄▅▆▃▃▄▄▄ █
  9.3 μs       Histogram: log(frequency) by time      21.1 μs <

 Memory estimate: 896 bytes, allocs estimate: 1.

julia> @benchmark logspace(1, 2, 100)
BenchmarkTools.Trial: 10000 samples with 10 evaluations.
 Range (min … max):  1.291 μs … 229.770 μs  ┊ GC (min … max): 0.00% … 98.99%
 Time  (median):     1.524 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.715 μs ±   2.574 μs  ┊ GC (mean ± σ):  1.94% ±  1.40%

  ▇█▄▂▅▆▅▅▄▄▂▃▂▂▂▃▂▂▂▁▁▁                                      ▂
  ████████████████████████████▇▇▇▇▇▇█▇▇▇▇▇▆▇▇▇▇▆▆▅▅▅▅▄▄▄▅▅▅▄▅ █
  1.29 μs      Histogram: log(frequency) by time      4.25 μs <

 Memory estimate: 896 bytes, allocs estimate: 1.
=#

#=
julia> @benchmark exp.(range(log(1), log(2), step=1/1000))
BenchmarkTools.Trial: 10000 samples with 6 evaluations.
 Range (min … max):  5.345 μs … 329.654 μs  ┊ GC (min … max): 0.00% … 80.26%
 Time  (median):     5.647 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   6.513 μs ±   7.458 μs  ┊ GC (mean ± σ):  2.49% ±  2.20%

  ██▆▃▁▃▃▄▄▇▄▄▁ ▁▁                                            ▂
  █████████████▇███▇▅▇▅▆▅▄▅▄▅▄▄▄▅▇▅▇▆▆▇▆▇▆▅▅▄▆▆▇▇▆▇▇▇▆▇▆▆▄▅▇▅ █
  5.35 μs      Histogram: log(frequency) by time      14.2 μs <

 Memory estimate: 5.56 KiB, allocs estimate: 1.

julia> @benchmark 2 .^range(log(2,1), log(2,2), step=1/1000)
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   9.927 μs … 475.411 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     10.767 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   11.566 μs ±   5.633 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▄█▆▅▅▃▅▄▃▅▃ ▁  ▃▃  ▁ ▁▄▃ ▁▃▁ ▅▆▅▂▃▅▅▂▁▂▁   ▂    ▂    ▂     ▁ ▂
  ██████████████▇██▇██████████▇███████████▇▃▆█▇▆▁██▇▆▁▅██▆▄▁▇█ █
  9.93 μs       Histogram: log(frequency) by time      15.4 μs <

 Memory estimate: 8.00 KiB, allocs estimate: 1.
=#
end
