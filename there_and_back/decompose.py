from there_and_back.system_prompts.decompose_system import system
from there_and_back.one_shot_examples.ark_example import ark_example

from there_and_back.utils import call_openai, clean_whitespace
from there_and_back.utils import domain_token, problem_token, story_token, error_token


def get_example_human_template():
    template = story_token + "\n{example_story}\n"
    return template


def get_example_ai_template():
    template = ""
    template += domain_token + "\n{example_domain}\n"
    template += problem_token + "\n{example_problem}\n"
    return template


def get_human_template():
    template = story_token + "\n{input_story}\n"
    return template


def _get_prompt(new_story, model_name):

    # Update the messages using your content functions
    system_message_prompt = {"role": "system", "content": system}
    example_human_template = get_example_human_template()
    example_ai_template = get_example_ai_template()
    human_template = get_human_template()

    example_human = {
        "role": "user",
        "content": example_human_template.format(example_story=ark_example.story),
    }
    example_ai = {
        "role": "assistant",
        "content": example_ai_template.format(
            example_domain=ark_example.domain, example_problem=ark_example.problem
        ),
    }
    human_message_prompt = {
        "role": "user",
        "content": human_template.format(input_story=new_story),
    }

    chat_prompt = [
        system_message_prompt,
        example_human,
        example_ai,
        human_message_prompt,
    ]

    chat_prompt = clean_whitespace(chat_prompt)

    metadata = {
        "model_name": model_name,
        # "runtime": f"{runtime:.2}s",
        "type": "decompose",
        "prompt": chat_prompt
    }

    return chat_prompt, metadata


def decompose(new_story, model_name, print_stream=True):
    temp = 0.2
    chat_prompt, metadata = _get_prompt(new_story, model_name)
    metadata["temperature"] = temp
    original_output, runtime = call_openai(chat_prompt, model_name, temp, return_stream=False, timeout=240, print_stream=print_stream)
    metadata["runtime"] = f"{runtime:.2}s"
    domain, problem = parse_for_pddl(original_output)

    return domain, problem, metadata


def decompose_stream(new_story, model_name, print_stream=True):
    temp = 0.2
    chat_prompt, metadata = _get_prompt(new_story, model_name)
    metadata["temperature"] = temp
    response = call_openai(chat_prompt, model_name, temp, return_stream=True, timeout=240, print_stream=print_stream)
    return response, metadata


def parse_for_pddl(output):
    domain_and_problem = (
        output.split(domain_token)[1] if domain_token in output else output
    )
    try:
        domain, problem = domain_and_problem.split(problem_token)
    except ValueError:
        print(f"{problem_token} not found in output")
        return "Unable to parse domain", "Unable to parse problem"

    print("Domain", domain)
    print("Problem", problem)
    domain = domain.replace(domain_token, "").strip()
    problem = problem.replace(problem_token, "").strip()
    return domain, problem

