hadamard(qubit) = BasicGate("hadamard", [qubit])

export apply_hadamard
function apply_hadamard(psi, qubits)
    tensor = (1.0 + 0.0im)*reshape([1 1; 1 -1]/sqrt(2), 2, 2)
    new_psi = apply(psi, tensor, qubits)
    return new_psi
end