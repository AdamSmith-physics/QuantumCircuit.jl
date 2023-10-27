hadamard(qubit) = BasicGate("hadamard", [qubit])
cnot(control, target) = BasicGate("cnot", [control, target])
cnot(qubits) = BasicGate("cnot", qubits)

export apply_hadamard
function apply_hadamard(psi, qubits)
    tensor = reshape([1 1; 1 -1]/sqrt(2), 2, 2)
    tensor = permutedims(tensor, [2,1])
    new_psi = apply(psi, tensor, qubits)
    return new_psi
end

export apply_cnot
function apply_cnot(psi, qubits)
    tensor = reshape([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0], 2, 2, 2, 2)
    tensor = permutedims(tensor, [4,3,2,1])
    new_psi = apply(psi, tensor, qubits)
    return new_psi
end