pattern_list = {
    "x86": {
        "branch": ['cmpl', ['jne', 'je', 'jnz', 'jz']], #cmp??
        "constant_coding": ['movl', 'movq', 'movw', '.value', ".long"],
        "loop_check": ['cmpl', 'cmpl', 'j'], #cmpb, cmp??
    },
    "arm": {
        "branch": ['cmp', [['beq', 'bne', 'bcs', 'bhs', 'bcc', 'blo', 'bmi', 'bpl', 'bvs', 'bvc', 'bhi', 'bls', 'bge',
                            'blt', 'bgt', 'ble', 'bal'],
                           ['moveq', 'movne', 'movcs', 'movhs', 'movcc', 'movlo', 'movmi', 'movpl', 'movvs', 'movvc',
                            'movhi', 'movls', 'movge', 'movlt', 'movgt', 'movle']]],
        # ! MOV is repeated here to maintain structure integrity.
        "constant_coding": ['mov', 'mvn', 'movgt', 'movle', 'moveq', 'movne', '.short', '.word'],
        "loop_check": [['ldr', 'ldrb'], 'cmp', 'b'],
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