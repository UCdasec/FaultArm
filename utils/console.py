from rich.console import Console

console = Console(color_system="auto", log_path=False, style="blue")
console._log_render.omit_repeated_times = False