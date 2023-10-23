"""
Gate object
gate: gate matrix
qubits: qubits to apply the gate to
"""
struct Gate
    type::String  # type of Gate. Matrix if using a specific matrix
    matrix::Array{ComplexF64}
    qubits::Vector{Int64}
end

export apply_gate
function apply_gate(psi::Array{ComplexF64}, gate::Array{ComplexF64}, qubits::Vector{Int64})
    # Apply a gate to a state vector
    # psi: state vector shape (2, 2, ...) for N qubits
    # gate: gate matrix
    # qubits: qubits to apply the gate to
    # returns: state vector with gate applied to qubits
    
    println("Applying gate to qubits: ", qubits)

    N = length(size(psi))
    gate_size = div(length(size(gate)), 2)
    num_qubits = length(qubits)

    # Check that the gate is the right size
    if gate_size != num_qubits
        error("Gate size does not match number of qubits in apply gate.")
    end

    gate_indices = [i + gate_size for i = 1:gate_size]

    new_psi = contract(psi, gate, qubits, gate_indices)
    # need reordering!!!

    return new_psi

end