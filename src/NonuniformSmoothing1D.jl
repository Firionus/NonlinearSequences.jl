module NonuniformSmoothing1D

using NonuniformResampling1D

export logspace

"""
TODO Docs go here
"""
function logspace end

# logspace with differing amounts of positional arguments
logspace(start, stop, length) = _logspace_start_stop_len(start, stop, length)

# logspace with 3 positional arguments
function logspace(start, stop, length)
    exp.(range(log(start), log(stop), length=length))
end

# logspace with 2 positional arguments
function logspace(start, stop; length=nothing, step=nothing, base=nothing, adjust_step=false)
    if !isnothing(length)
        (isnothing(step) && isnothing(base)) || 
            @warn "step and base are ignored when length is specified"
        logspace(start, stop, length)
    else
        (!isnothing(step) && !isnothing(base)) || throw(
            ArgumentError("define either length or step and base")
        )
        _logspace_start_stop_step(start, stop, step, base, adjust_step)
    end
end

# logspace with 1 positional argument
function logspace(start; stop=nothing, length=nothing, step=nothing, base=nothing) 
    if !isnothing(stop)
        logspace(start, stop, length=length, step=step, base=base)
    else
        throw(ArgumentError("stop must be defined"))
    end
end

# logspace with 0 positional arguments
logspace(; start, stop=nothing, length=nothing, step=nothing, base=nothing) = logspace(start, stop=stop, length=length, step=step, base=base)

# logspace private implementations

_logspace(start, stop, length, step::Nothing, base::Nothing, adjust_step::Nothing) = logspace(start, stop, length)
_logspace(start, stop, length::Nothing, step, base, adjust_step) = _logspace_start_stop_step(start, stop, step, base, adjust_step)

# Implementations
# ===============
function _logspace_start_stop_len(start, stop, length)
    exp.(range(log(start), log(stop), length=length))
end

# TODO if adjust_step is set in other variants, a warning should be logged
function _logspace_start_stop_step(start, stop, step, base, adjust_step)
    logsize = log(base, stop/start)
    println("start ", start, " stop ", stop)
    println("logsize ", logsize)
    println("base ", base, " step ", step)
    println("length before rounding ", logsize/step)
    length = (logsize/step + 1)|>floor|>Int

    if adjust_step
        println("step is adjusted")
        logspace(start, stop, length)
    else
        adjusted_logsize = (length - 1)*step
        adjusted_stop = base^adjusted_logsize*start
        logspace(start, adjusted_stop, length)
    end
end

function _logspace_start_len_step(start, length, step, base)

end

function _logspace_stop_step_len(stop, length, step, base)

end

#=
function logspace(start, stop; points_per_octave=24, length=nothing)
    if length===nothing
        points = Int(round(log2(stop/start)*points_per_octave))
    else
        points = length
    end
        log_of_values = range(log(start), stop=log(stop), length=points)
        values = exp.(log_of_values)
    return values
end
=#

function powspace()
    TODO()
end

# TODO: re-export stuff from NonuniformSmoothing1D

end
