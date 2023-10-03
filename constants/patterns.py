pattern_list = {
    "x86": {
        "branch": ['cmpl', ['jne', 'je', 'jnz', 'jz']],
        "constant_coding": ['movl', 'movq', 'movw', '.value', ".long"],
    },
    "arm": {
        "branch": ['cmp', ['bne', 'be', 'beq']],
        "constant_coding": ['mov', '.short', '.long'],
    }
}

