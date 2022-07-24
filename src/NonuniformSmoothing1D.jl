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
logspace(start, stop; length=nothing, step=nothing, base=nothing, 
    adjust_step=nothing) = _logspace(start, stop, length, step, base, adjust_step)

# 1 positional argument
logspace(start; stop=nothing, length=nothing, step=nothing, base=nothing, 
    adjust_step=nothing) = _logspace(start, stop, length, step, base, adjust_step)

# 0 positional arguments
logspace(; start=nothing, stop=nothing, length=nothing, step=nothing, base=nothing,
    adjust_step=nothing) = _logspace(start, stop, length, step, base, adjust_step)

# _logspace dispatch to specific implementations

# normal case
_logspace(start, stop, length, step::Nothing, base::Nothing, adjust_step::Nothing) = logspace(start, stop, length)
# start_stop_step with default for adjust_step
_logspace(start, stop, length::Nothing, step, base, adjust_step::Nothing) = _logspace_start_stop_step(start, stop, step, base, false)
_logspace(start, stop, length::Nothing, step, base, adjust_step) = _logspace_start_stop_step(start, stop, step, base, adjust_step)
# start_len_step
_logspace(start, stop::Nothing, length, step, base, adjust_step::Nothing) = _logspace_start_len_step(start, length, step, base)
# stop_len_step
_logspace(start::Nothing, stop, length, step, base, adjust_step::Nothing) = _logspace_stop_len_step(stop, length, step, base)


# Errors and Warnings
_logspace(start, stop::Nothing, length::Nothing, step, base, adjust_step::Nothing) = throw(
    ArgumentError("stop or length must be defined")
)
_logspace(start, stop::Nothing, length::Nothing, step, base, adjust_step) = throw(
    ArgumentError("stop or length must be defined")
)
_logspace(start, stop::Nothing, length::Nothing, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just start")
)
_logspace(start::Nothing, stop, length::Nothing, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just stop")
)
_logspace(start::Nothing, stop::Nothing, length, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just length")
)
_logspace(start::Nothing, stop::Nothing, length::Nothing, step, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just step")
)
_logspace(start::Nothing, stop::Nothing, length::Nothing, step::Nothing, base, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just step")
)
_logspace(start::Nothing, stop::Nothing, length::Nothing, step, base, adjust_step::Nothing) = throw(
    ArgumentError("provide more arguments than just step and base")
)
_logspace(start, stop::Nothing, length, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide stop or step and base")
)
_logspace(start, stop, length::Nothing, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide length or step and base")
)
_logspace(start::Nothing, stop::Nothing, length::Nothing, step, base, adjust_step) = throw(
    ArgumentError("either start or stop must be provided")
)
_logspace(start::Nothing, stop::Nothing, length, step, base, adjust_step) = throw(
    ArgumentError("either start or stop must be provided")
)
_logspace(start::Nothing, stop, length, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("provide start or step and base")
)
_logspace(start::Nothing, stop::Nothing, length::Nothing, step::Nothing, base::Nothing, adjust_step::Nothing) = throw(
    ArgumentError("all arguments are nothing")
)
_logspace(start::Nothing, stop, length, step, base, adjust_step) = begin
    @warn "step, base and adjust_step are ignored when length is given"
    _logspace_stop_len_step(stop, length, step, base)
end
_logspace(start, stop, length, step, base, adjust_step) = begin
    @warn "step, base and adjust_step are ignored when length is given"
    logspace(start, stop, length)
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
