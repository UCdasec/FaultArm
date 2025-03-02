pattern_list = {
    "x86": {
        "branch": [['cmpl'], ['jne', 'je', 'jnz', 'jz'], []], #cmp??
        "constant_coding": ['movl', 'movq', 'movw', '.value', ".long"],
        "loop_check": ['cmpl', 'cmpl', 'j'], #cmpb, cmp??
        "bypass": [[], []]
    },
    "arm": {
        "branch": [['cmp', 'subs', 'rsbs'], ['beq', 'bne', 'bcs', 'bhs', 'bcc', 'blo', 'bmi', 'bpl', 'bvs', 'bvc', 'bhi', 'bls', 'bge',
                            'blt', 'bgt', 'ble', 'bal', 'bxeq', 'bxne', 'bxcs', 'bxhs', 'bxcc', 'bxlo', 'bxmi', 'bxpl',
                            'bxvs', 'bxvc', 'bxhi', 'bxls', 'bxge', 'bxlt', 'bxgt', 'bxle', 'bxal'],
                           ['moveq', 'movne', 'movcs', 'movhs', 'movcc', 'movlo', 'movmi', 'movpl', 'movvs', 'movvc',
                            'movhi', 'movls', 'movge', 'movlt', 'movgt', 'movle', 'ldreq', 'ldrne']],
        # ! MOV is repeated here to maintain structure integrity.
        "constant_coding": ['mov', 'mvn', 'movgt', 'movle', 'moveq', 'movne', '.short', '.word'],
        "loop_check": [['ldr', 'ldrb', 'ldrh'], 'cmp', ['b', 'blt', 'bgt', 'bne', 'beq', 'ble', 'bge']],
        "bypass": [['bl', 'str', 'ldr', ['cmp', 'subs', 'rsbs'], ['beq', 'bgt', 'ble', 'bne', 'movne', 'moveq', 'movgt', 'movcc', 'ldrne', 'ldreq']],
                   ['bl', 'mov', ['cmp', 'subs', 'rsbs'], ['beq', 'bgt', 'ble', 'bne', 'movne', 'moveq', 'movgt', 'movcc', 'ldrne', 'ldreq']]]
    }
}


branch_opposites = {
    "arm": {
        "beq": "bne",
        "bne": "beq",
        "bgt": "ble",
        "blt": "bge",
        "bge": "blt",
        "ble": "bgt",
        "bcs": "bcc",
        "bcc": "bcs",
        "bmi": "bpl",
        "bpl": "bmi",
        "bvs": "bvc",
        "bvc": "bvs",
        "bal": "bal"  # bal (always) doesn't really have an opposite
    }
}

optimization_levels = {
    (6, 3): "O0",
    (1, 3): "O1", # can also be Og
    (2, 3): "O2",
    (2, 1): "Ofast",
    (4, 3): "Os"
}