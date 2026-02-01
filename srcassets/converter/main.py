import re
from pathlib import Path

ACT_RE = re.compile(r"\[act(\d+)\]")
OPTIONS_RE = re.compile(r"\[(.*?)\]")
QUESTION_RE = re.compile(r"\[question\]")
CHOICE_RE = re.compile(r"\[(\d+)\]\s*(.*)")
IF_RE = re.compile(r"\[if(\d+)\]")
END_QUESTION_RE = re.compile(r"\[end_question\]")

def parse_options(option_string):
	if option_string.strip() == "":
		return {}

	opts = {}
	for pair in option_string.split(","):
		k, v = pair.split("=", 1)
		k = k.strip()
		v = v.strip()

		if k in ("character", "scenario"):
			opts[k] = v
		elif v.lower() in ("true", "false"):
			opts[k] = v.lower()
		elif v.replace(".", "", 1).isdigit():
			opts[k] = v
		else:
			opts[k] = f"\"{v}\""

	return opts

def options_to_gd(opts):
	return "{" + ", ".join(f"{k}={v}" for k, v in opts.items()) + "}"

def convert(input_path, output_path):
	lines = Path(input_path).read_text(encoding="utf-8").splitlines()
	out = []

	indent = "\t"

	text_buffer = []
	current_opts = None
	question_opts = None
	branch_opts = None

	in_question = False
	choices = []
	branches = {}
	current_if = None

	result_declared = False

	act_characters = set()
	act_locations = set()
	act_header_index = None

	def emit_assets():
		if act_header_index is None:
			return

		insert = []
		if act_characters:
			insert.append(indent + "# characters")
			for c in sorted(act_characters):
				path = f"res://assets/characters/{c}/{c}.tscn"
				insert.append(indent + f'var {c} := vn_controller.load_character("{path}")')

		if act_locations:
			insert.append(indent + "# locations")
			for l in sorted(act_locations):
				path = f"res://assets/locations/{l}/{l}.tscn"
				insert.append(indent + f'var {l} := "{path}"')

		out[act_header_index + 1:act_header_index + 1] = insert

	def flush_text(target=None, opts_override=None):
		nonlocal text_buffer, current_opts, branch_opts
		if not text_buffer:
			return

		quoted = [f"\"{t}\"" for t in text_buffer]
		opts = options_to_gd(opts_override or current_opts or {})
		line = f'await vn_controller.show_texts([{", ".join(quoted)}], {opts})'

		if target is not None:
			target.append(line)
		else:
			out.append(indent + line)

		text_buffer = []
		current_opts = None
		branch_opts = None

	for raw in lines:
		line = raw.strip()
		if not line:
			continue

		m = ACT_RE.match(line)
		if m:
			flush_text()
			emit_assets()

			act_characters = set()
			act_locations = set()

			out.append(f"\nfunc _act_{m.group(1)}():")
			act_header_index = len(out) - 1
			continue

		if QUESTION_RE.match(line):
			flush_text()
			in_question = True
			choices = []
			branches = {}
			current_if = None
			question_opts = current_opts
			current_opts = None
			continue

		m = CHOICE_RE.match(line)
		if in_question and m:
			choices.append(m.group(2))
			continue

		m = IF_RE.match(line)
		if m:
			current_if = int(m.group(1))
			branches[current_if] = []
			continue

		if END_QUESTION_RE.match(line):
			assign = "var result =" if not result_declared else "result ="
			result_declared = True

			opts = options_to_gd(question_opts or {})
			out.append(indent + f"{assign} await vn_controller.show_options([")
			for c in choices:
				out.append(indent * 2 + f"\"{c}\",")
			out.append(indent + f"], {opts})\n")

			out.append(indent + "match result:")
			for idx, code in branches.items():
				out.append(indent * 2 + f"{idx}:")
				out.extend(indent * 3 + l for l in code)

			in_question = False
			current_if = None
			question_opts = None
			continue

		m = OPTIONS_RE.match(line)
		if m:
			content = m.group(1)
			opts = parse_options(content)

			if in_question and current_if is not None:
				branch_opts = opts
				continue

			flush_text()

			if "character" in opts:
				act_characters.add(opts["character"])

			if "scenario" in opts:
				act_locations.add(opts["scenario"])
				time = opts.get("time", "0.0")
				out.append(indent + f"await vn_controller.set_location({opts['scenario']}, {time})")

			elif "fade_in" in opts:
				out.append(indent + f"await vn_controller.fade_screen(1.0, {opts['fade_in']})")

			elif "fade_out" in opts:
				out.append(indent + f"await vn_controller.fade_screen(0.0, {opts['fade_out']})")

			else:
				current_opts = opts
			continue

		if in_question and current_if is not None:
			text_buffer.append(line)
			flush_text(branches[current_if], branch_opts)
		else:
			text_buffer.append(line)

	flush_text()
	emit_assets()

	Path(output_path).write_text("\n".join(out), encoding="utf-8")

if __name__ == "__main__":
	convert("input.txt", "output.txt")
