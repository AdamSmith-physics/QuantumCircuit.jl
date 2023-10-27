export BasicGate
struct BasicGate
    type::String  # name of predefined gate
    qubits::Vector{Int64}
end

export ParametrisedGate
struct ParametrisedGate
    type::String  # name of predefined gate
    params::Vector{Float64}
    qubits::Vector{Int64}
end

export GeneralGate
struct GeneralGate
    matrix::Matrix{ComplexF64}
    qubits::Vector{Int64}
end

export apply
function apply(psi::Array{ComplexF64}, tensor::Array{ComplexF64}, qubits::Vector{Int64})
    # Apply a gate to a state vector
    # psi: state vector shape (2, 2, ...) for N qubits
    # gate: gate matrix
    # qubits: qubits to apply the gate to
    # returns: state vector with gate applied to qubits
    
    println("Applying gate to qubits: ", qubits)

    N = length(size(psi))
    gate_size = div(length(size(tensor)), 2)
    num_qubits = length(qubits)

    # Check that the gate is the right size
    if gate_size != num_qubits
        error("Gate size does not match number of qubits in apply gate.")
    end

    gate_indices = [i + gate_size for i = 1:gate_size]

    psi = contract(psi, tensor, qubits, gate_indices)
    println("Intermediate psi = $([psi...]))")
    
    from = [N-length(qubits)+i for i = 1:length(qubits)]

    println("Moving qubits from $(from)")

    psi = moveaxis(psi, from, qubits)

    return psi

end

function apply(psi::Array{ComplexF64}, gate::GeneralGate)::Array{ComplexF64}
    matrix = gate.matrix
    tensor = reshape(matrix, (2 for _ in 1:2*length(gate.qubits))...)
    tensor = permutedims(tensor, [i for i in 2*length(gate.qubits):-1:1])

    return apply(psi, tensor, gate.qubits)
end


function apply(psi::Array{ComplexF64}, gate::BasicGate)::Array{ComplexF64}
    if gate.type == "hadamard"
        return apply_hadamard(psi, gate.qubits)
    else
        error("Gate not recognised.")
    end
end



