using TensorOperations

function apply_gate(psi::Array{ComplexF64}, gate::Array{ComplexF64}, qubits::Vector{Int64})
    # Apply a gate to a state vector
    # psi: state vector
    # gate: gate matrix
    # qubits: qubits to apply the gate to
    # returns: state vector with gate applied to qubits
    
    println("Applying gate to qubits: ", qubits)

end

function test()

    println("Testing circuits.jl")

end
