
class Results:
    def __init__(self, all_vulnerable_lines: list[list[str]], total_lines: int, out_directory: str, ) -> None:
        self.all_vulnerable_lines = all_vulnerable_lines
        
        self.total_lines = total_lines
        self.total_vulnerable_lines = sum(len(sublist) for sublist in all_vulnerable_lines)
        
