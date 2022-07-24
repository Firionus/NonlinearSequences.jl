module NonuniformSmoothing1D

using NonuniformResampling1D

export logspace

"""
TODO Docs go here
"""
function logspace end

# logspace with differing amounts of positional arguments

# 3 positional arguments
function logspace(start, stop, length)
    exp.(range(log(start), log(stop), length=length))
end

# 2 positional arguments
logspace(start, stop; kwargs...) = logspace(start=start, stop=stop; kwargs...)

# 1 positional argument
logspace(start; kwargs...) = logspace(start=start; kwargs...)

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
                throw(ArgumentError("provide length or step and base"))
            end
        end
    else # start === nothing
        if stop|>isnothing || length|>isnothing || step|>isnothing || base|>isnothing
            throw(ArgumentError("either provide start or all of stop, length, step and base"))
        end
        warn_adjust_step(adjust_step)
        _logspace_stop_len_step(stop, length, step, base)
    end
end

warn_adjust_step(adjust_step) = if adjust_step !== nothing
    @warn "adjust_step is ignored when length is given"
end

ensure_step_base(step, base) = if step|>isnothing || base|>isnothing
    throw(ArgumentError("provide step and base"))
end

function _logspace_start_stop_step(start, stop, step, base, adjust_step)
    isnothing(step) && throw(ArgumentError("keyword argument step must be defined"))
    isnothing(base) && throw(ArgumentError("keyword argument base must be defined"))

    logstart = log(base, start)
    logstop = log(base, stop)

    if adjust_step
        logsize = log(base, stop/start)
        length = (logsize/step + 1)|>floor|>Int
        base.^range(logstart, logstop, length=length)
    else
        base.^range(logstart, logstop, step=step)
    end
end

function _logspace_start_len_step(start, length, step, base)
    logstart = log(base, start)
    base.^range(logstart, length=length, step=step)
end

function _logspace_stop_len_step(stop, length, step, base)
    logstop = log(base, stop)
    base.^range(stop=logstop, length=length, step=step)
end

function powspace()
    TODO()
end

# TODO: re-export stuff from NonuniformSmoothing1D

# TODO move logspace and powspace to their own files

end
