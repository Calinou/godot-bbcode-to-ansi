extends Control


func _ready() -> void:
	print(bbcode_to_ansi($RichTextLabel.text))


func bbcode_to_ansi(p_bbcode: String) -> String:
	# `\u001b` is the Unicode escape sequence for the ANSI escape code
	# (also known as `\033` and `\x1b`).
	var begin := Time.get_ticks_usec()
	var res := (p_bbcode
			# Bold.
			.replace("[b]", "\u001b[1m")
			.replace("[/b]", "\u001b[22m")
			# Italic.
			.replace("[i]", "\u001b[3m")
			.replace("[/i]", "\u001b[23m")
			# Underline.
			.replace("[u]", "\u001b[4m")
			.replace("[/u]", "\u001b[24m")
			# Strikethrough.
			.replace("[s]", "\u001b[9m")
			.replace("[/s]", "\u001b[29m")
			# Indentation (looks equivalent to 4 spaces).
			.replace("[indent]", "    ")
			.replace("[/indent]", "")
			
			# Code.
			# Terminal fonts are already fixed-width, so use faint coloring to distinguish it
			# from normal text.
			.replace("[code]", "\u001b[2m")
			.replace("[/code]", "\u001b[22m")
			
			# Without knowing the terminal width, we can't fully emulate [center] and [right] behavior.
			# This is only an approximation that doesn't take the terminal width into account.
			.replace("[center]", "\n\t\t\t")
			.replace("[/center]", "")
			.replace("[right]", "\n\t\t\t\t\t\t")
			.replace("[/right]", "")
			
			# Text color.
			.replace("[color=black]", "\u001b[30m")
			.replace("[color=red]", "\u001b[91m")
			.replace("[color=green]", "\u001b[92m")
			.replace("[color=lime]", "\u001b[92m")
			.replace("[color=yellow]", "\u001b[93m")
			.replace("[color=blue]", "\u001b[94m")
			.replace("[color=magenta]", "\u001b[95m")
			.replace("[color=pink]", "\u001b[95m")
			.replace("[color=purple]", "\u001b[95m")
			.replace("[color=cyan]", "\u001b[96m")
			.replace("[color=white]", "\u001b[97m")
			.replace("[color=orange]", "\u001b[38;2;255;165;0m")
			.replace("[color=gray]", "\u001b[90m")
			.replace("[/color]", "\u001b[39m")
			
			# Background color.
			.replace("[bgcolor=black]", "\u001b[40m")
			.replace("[bgcolor=red]", "\u001b[101m")
			.replace("[bgcolor=green]", "\u001b[102m")
			.replace("[bgcolor=lime]", "\u001b[102m")
			.replace("[bgcolor=yellow]", "\u001b[103m")
			.replace("[bgcolor=blue]", "\u001b[104m")
			.replace("[bgcolor=magenta]", "\u001b[105m")
			.replace("[bgcolor=pink]", "\u001b[105m")
			.replace("[bgcolor=purple]", "\u001b[105m")
			.replace("[bgcolor=cyan]", "\u001b[106m")
			.replace("[bgcolor=white]", "\u001b[107m")
			.replace("[bgcolor=orange]", "\u001b[48;2;255;165;0m")
			.replace("[bgcolor=gray]", "\u001b[100m")
			.replace("[/bgcolor]", "\u001b[49m")
	)
	
	var end := Time.get_ticks_usec()
	
	print("Replacing BBCode with ANSI escape codes in the text below took %d microseconds.\n----\n" % (end - begin))
	
	return res
