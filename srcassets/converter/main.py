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
        try:
            k, v = pair.split("=")
            k = k.strip()
            v = v.strip()

            if k in ("character", "scenario"):
                opts[k] = v  # raw identifier
            elif v.lower() in ("true", "false"):
                opts[k] = v.lower()
            elif v.replace(".", "", 1).isdigit():
                opts[k] = v
            else:
                opts[k] = f"\"{v}\""
        except ValueError:
            print(pair)
            raise


    return opts

def options_to_gd(opts):
    return "{" + ", ".join(f"{k}={v}" for k, v in opts.items()) + "}"

def convert(input_path, output_path):
    lines = Path(input_path).read_text(encoding="utf-8").splitlines()
    out = []

    indent = "    "
    current_opts = None
    text_buffer = []

    in_question = False
    choices = []
    branches = {}
    current_if = None

    def flush_text(target=None):
        nonlocal text_buffer, current_opts
        if not text_buffer:
            return
        opts = options_to_gd(current_opts or {})
        line = f'await vn_controller.show_texts({text_buffer}, {opts})'
        if target is not None:
            target.append(line)
        else:
            out.append(indent + line)
        text_buffer = []
        current_opts = None

    for raw in lines:
        line = raw.strip()
        if not line:
            continue

        # Act
        if ACT_RE.match(line):
            flush_text()
            act_num = ACT_RE.match(line).group(1)
            out.append(f"\nfunc _act_{act_num}():")
            continue

        # Question
        if QUESTION_RE.match(line):
            flush_text()
            in_question = True
            choices = []
            branches = {}
            continue

        # Choice
        if in_question and CHOICE_RE.match(line):
            _, text = CHOICE_RE.match(line).groups()
            choices.append(text)
            continue

        # If block
        if IF_RE.match(line):
            flush_text(branches.get(current_if))
            current_if = int(IF_RE.match(line).group(1))
            branches[current_if] = []
            continue

        # End question
        if END_QUESTION_RE.match(line):
            out.append(indent + "var result = await vn_controller.show_options([")
            for c in choices:
                out.append(indent * 2 + f"\"{c}\",")
            out.append(indent + "])\n")
            out.append(indent + "match result:")
            for idx, code in branches.items():
                out.append(indent * 2 + f"{idx}:")
                out.extend(indent * 3 + l for l in code)
            in_question = False
            current_if = None
            continue

        # Options / commands
        if OPTIONS_RE.match(line):
            flush_text()
            content = OPTIONS_RE.match(line).group(1)
            opts = parse_options(content)

            # Scenario command
            if "scenario" in opts:
                scenario = opts["scenario"]
                time = opts.get("time", "0.0")
                out.append(
                    indent + f"await vn_controller.set_location({scenario}, {time})"
                )
            else:
                current_opts = opts
            continue

        # Normal text
        if in_question and current_if is not None:
            branches[current_if].append(
                f'await vn_controller.show_texts([\"{line}\"], {{}})'
            )
        else:
            text_buffer.append(f"{line}")

    flush_text()
    Path(output_path).write_text("\n".join(out), encoding="utf-8")


if __name__ == "__main__":
    convert("input.txt", "output.txt")
