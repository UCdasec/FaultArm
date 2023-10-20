pattern_list = {
    "x86": {
        "branch": ['cmpl', ['jne', 'je', 'jnz', 'jz']],
        "constant_coding": ['movl', 'movq', 'movw', '.value', ".long"],
        "loop_check": ['cmpl', 'cmpl', 'j'],
    },
    "arm": {
        "branch": ['cmp', ['bne', 'be', 'beq']],
        # ! MOV is repeated here to maintain structure integrity.
        "constant_coding": ['mov', 'mov', 'mov', '.short', '.word'],
        "loop_check": ['ldr', 'cmp', 'b'],
    }
}


branch_opposites = {
    "arm": {
        "BEQ": "BNE",
        "BNE": "BEQ",
        "BGT": "BLE",
        "BLT": "BGE",
        "BGE": "BLT",
        "BLE": "BGT",
        "BCS": "BCC",
        "BCC": "BCS",
        "BMI": "BPL",
        "BPL": "BMI",
        "BVS": "BVC",
        "BVC": "BVS",
        "BAL": "BAL"  # BAL (always) doesn't really have an opposite
    }
}