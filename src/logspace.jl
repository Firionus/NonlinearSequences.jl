"""
    logspace(start, stop, length)
    logspace(start, stop; length, step, base, adjust_step)
    logspace(start; stop, length, step, base, adjust_step)
    logspace(; start, stop, length, step, base, adjust_step)

Returns an array of logarithmically spaced values. 

All arguments can be provided as keyword arguments. Additionally, `start`,
`stop` and `length` can be provided as positional arguments. 

4 different combinations of arguments are valid:
- `start`, `stop` and `length`: `length` many values from `start` to `stop`.
- `start`, `stop`, `step` and `base`: values from `start` up to `stop` whose
  logarithms of base `base` are spaced linearly with `step`. By default, the
  step size is obeyed and values may end before `stop`. To adjust the step to
  reach `stop` precisely, set `adjust_step=true`.
- `start`, `step`, `base`, `length`: `length` many values starting at `start`
  whose logarithms of base `base` are spaced linearly with `step`.
- `stop`, `step`, `base`, `length`: `length` many values ending at `stop` whose
  logarithms of base `base` are spaced linearly with `step`.

# Examples
```jldoctest
julia> logspace(1, 2, 3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(1, 2.1, step=1/2, base=2)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(1, 2.1, step=1/2, base=2, adjust_step=true)
3-element Vector{Float64}:
 1.0
 1.449137674618944
 2.1

julia> logspace(1, step=1/2, base=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(stop=2, step=1/2, base=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(start=1, stop=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(stop=1, step=-1/2, base=2, length=3)
3-element Vector{Float64}:
 2.0
 1.414213562373095
 1.0
```
"""
function logspace end

# logspace with differing amounts of positional arguments

# 3 positional arguments
function logspace(start, stop, length)
    exp.(range(log(start), log(stop), length=length))
end

# 2 positional arguments
logspace(start, stop; length=nothing, step=nothing, base=nothing, 
adjust_step=nothing) = logspace(start=start, stop=stop, length=length, 
step=step, base=base, adjust_step=adjust_step)

# 1 positional argument
logspace(start; stop=nothing, length=nothing, step=nothing, base=nothing, 
adjust_step=nothing) = logspace(start=start, stop=stop, length=length, 
step=step, base=base, adjust_step=adjust_step)

# 0 positional arguments
function logspace(; start=nothing, stop=nothing, length=nothing, step=nothing, 
    base=nothing, adjust_step=nothing)
    if start !== nothing
        if stop !== nothing
            if length !== nothing
                if !(step|>isnothing && base|>isnothing)
                    @warn "step and base are ignored when start, stop and length are given"
                end
                warn_adjust_step(adjust_step)
                logspace(start, stop, length)
            else # length === nothing
                ensure_step_base(step, base)
                adjust_step = adjust_step|>isnothing ? false : adjust_step
                _logspace_start_stop_step(start, stop, step, base, adjust_step)
            end
        else # stop === nothing
            if length !== nothing
                ensure_step_base(step, base)
                warn_adjust_step(adjust_step)
                _logspace_start_len_step(start, length, step, base)
            else # length === nothing
                throw(ArgumentError("provide length or stop"))
            end
        end
    else # start === nothing
        if stop|>isnothing || length|>isnothing || step|>isnothing || base|>isnothing
            throw(ArgumentError("either provide start or all of stop, length and step"))
        end
        warn_adjust_step(adjust_step)
        _logspace_stop_len_step(stop, length, step, base)
    end
end

warn_adjust_step(adjust_step) = if adjust_step !== nothing
    @warn "adjust_step is ignored when length is given"
end

function ensure_step_base(step, base) 
    step|>isnothing && throw(ArgumentError("provide step"))
    base|>isnothing && throw(ArgumentError("provide base for step"))
end

function _logspace_start_stop_step(start, stop, step, base, adjust_step)
    isnothing(step) && throw(ArgumentError("keyword argument step must be defined"))
    isnothing(base) && throw(ArgumentError("keyword argument base must be defined"))

    logstart = log(start)
    logstop = log(stop)

    if adjust_step
        logsize = log(base, stop/start)
        length = (logsize/step + 1)|>floor|>Int
        exp.(range(logstart, logstop, length=length))
    else
        logstep = log(base)*step
        exp.(range(logstart, logstop, step=logstep))
    end
end

function _logspace_start_len_step(start, length, step, base)
    logstart = log(start)
    logstep = log(base)*step
    exp.(range(logstart, length=length, step=logstep))
end

function _logspace_stop_len_step(stop, length, step, base)
    logstop = log(stop)
    logstep = log(base)*step
    exp.(range(stop=logstop, length=length, step=logstep))
end