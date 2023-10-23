

export zero_state
"""
Creates the initial state |000...> of the quantum computer
"""
function zero_state(N::Int)::Array{ComplexF64}
    psi = zeros(ComplexF64, (2 for _ in 1:N)...)
    psi[1] = 1.0 + 0.0im
    return psi
end

export product_state
function product_state(configuration::Vector{Int})::Array{ComplexF64}
    psi = zeros(ComplexF64, (2 for _ in 1:N)...)
    psi[configuration...] = 1.0 + 0.0im
    return psi
end

export state_from_vector
function state_from_vector(state::Vector{<:Number})::Array{ComplexF64}
    N = log2(length(state))

    @assert isinteger(N)
    N = round(N)

    # Add a norm check!

    psi = reshape(state, (2 for _ in 1:N)...)
    return psi
end