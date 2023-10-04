pattern_list = {
    "x86": {
        "branch": ['cmpl', ['jne', 'je', 'jnz', 'jz']],
        "constant_coding": ['movl', 'movq', 'movw', '.value', ".long"],
    },
    "arm": {
        "branch": ['cmp', ['bne', 'be', 'beq']],
        # ! MOV is repeated here to maintain structure integrity.
        "constant_coding": ['mov', 'mov', 'mov', '.short', '.word'],
    }
}

