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
			
			# URL (link).
			# Only unnamed URLs can be universally supported in terminals (by letting the terminal
			# recognize it as-is). As of April 2022, support for named URLs is still in progress
			# for many popular terminals.
			.replace("[url]", "")
			.replace("[/url]", "")
			
			# Text color.
			.replace("[color=black]", "\u001b[30m")
			.replace("[color=red]", "\u001b[91m")
			.replace("[color=green]", "\u001b[92m")
			.replace("[color=lime]", "\u001b[92m")
			.replace("[color=yellow]", "\u001b[93m")
			.replace("[color=blue]", "\u001b[94m")
			.replace("[color=magenta]", "\u001b[95m")
			.replace("[color=pink]", "\u001b[38;5;218m")
			.replace("[color=purple]", "\u001b[38;5;98m")
			.replace("[color=cyan]", "\u001b[96m")
			.replace("[color=white]", "\u001b[97m")
			.replace("[color=orange]", "\u001b[38;5;208m")
			.replace("[color=gray]", "\u001b[90m")
			.replace("[/color]", "\u001b[39m")
			
			# Background color (highlighting text).
			.replace("[bgcolor=black]", "\u001b[40m")
			.replace("[bgcolor=red]", "\u001b[101m")
			.replace("[bgcolor=green]", "\u001b[102m")
			.replace("[bgcolor=lime]", "\u001b[102m")
			.replace("[bgcolor=yellow]", "\u001b[103m")
			.replace("[bgcolor=blue]", "\u001b[104m")
			.replace("[bgcolor=magenta]", "\u001b[105m")
			.replace("[bgcolor=pink]", "\u001b[48;5;218m")
			.replace("[bgcolor=purple]", "\u001b[48;5;98m")
			.replace("[bgcolor=cyan]", "\u001b[106m")
			.replace("[bgcolor=white]", "\u001b[107m")
			.replace("[bgcolor=orange]", "\u001b[48;5;208m")
			.replace("[bgcolor=gray]", "\u001b[100m")
			.replace("[/bgcolor]", "\u001b[49m")
			
			# Foreground color (redacting text).
			# Emulated by using the same color for both foreground and background.
			.replace("[fgcolor=black]", "\u001b[30;40m")
			.replace("[fgcolor=red]", "\u001b[91;101m")
			.replace("[fgcolor=green]", "\u001b[92;102m")
			.replace("[fgcolor=lime]", "\u001b[92;102m")
			.replace("[fgcolor=yellow]", "\u001b[93;103m")
			.replace("[fgcolor=blue]", "\u001b[94;104m")
			.replace("[fgcolor=magenta]", "\u001b[95;105m")
			.replace("[fgcolor=pink]", "\u001b[38;5;218;48;5;218m")
			.replace("[fgcolor=purple]", "\u001b[38;5;98;48;5;98m")
			.replace("[fgcolor=cyan]", "\u001b[96;106m")
			.replace("[fgcolor=white]", "\u001b[97;107m")
			.replace("[fgcolor=orange]", "\u001b[38;5;208;48;5;208m")
			.replace("[fgcolor=gray]", "\u001b[90;100m")
			.replace("[/fgcolor]", "\u001b[39;49m")
	)
	
	var end := Time.get_ticks_usec()
	
	print("Replacing BBCode with ANSI escape codes in the text below took %d microseconds.\n----\n" % (end - begin))
	
	return res
