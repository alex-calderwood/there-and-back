from there_and_back.system_prompts.fix_decompose_system import system
from there_and_back.one_shot_examples.ark_example_broken import ark_example_broken
from there_and_back.one_shot_examples.ark_example_decompose import ark_example

from there_and_back.decompose import parse_for_pddl, domain_token, problem_token, story_token, error_token
from there_and_back.utils import call_openai, clean_whitespace

def get_example_human_template():
    template = story_token + "\n{example_story}\n"
    template += domain_token + "\n{example_domain_broken}\n"
    template += problem_token + "\n{example_problem_broken}\n"
    template += error_token + "\n{example_error}\n"
    return template


def get_example_ai_template():
    template = ""
    template += domain_token + "\n{example_domain_fixed}\n"
    template += problem_token + "\n{example_problem_fixed}\n"
    return template


def get_human_template():
    template = story_token + "\n{input_story}\n"
    template += domain_token + "\n{input_domain}\n"
    template += problem_token + "\n{input_problem}\n"
    template += error_token + "\n{input_error}\n"
    return template


def fix_decompose(story, domain, problem, plan_metadata, model_name):
    temp = 0.2  # we are not interested in creativity - Jack

    # Update the messages using your content functions
    system_message_prompt = {"role": "system", "content": system}
    example_human_template = get_example_human_template()
    example_ai_template = get_example_ai_template()
    human_template = get_human_template()

    example_human = {
        "role": "user",
        "content": example_human_template.format(
            example_story=ark_example_broken.story,
            example_domain_broken=ark_example_broken.domain,
            example_problem_broken=ark_example_broken.problem,
            example_error=ark_example_broken.error
        ),
    }
    example_ai = {
        "role": "assistant",
        "content": example_ai_template.format(
            example_domain_fixed=ark_example.domain,
            example_problem_fixed=ark_example.problem
        ),
    }


    if plan_metadata["compiled"] and not plan_metadata["planned"]:
        error = """
No solutions found. The domain and problem compiled, but the planner failed to find a solution or timed out. (Note: There are a few common solutions. Ensure that characters have intentions that will lead to them taking actions that will fulfill the author's :goal. If there is not a clear sequence of motivated character actions that will solve the author's :goal, the planner will not be able to find a solution. One potential fix is to add character intentions to the problem. Another fix is to add or relax author goals such that at least one character's intentions will produce a sequence of motivated actions that will achieve each predicate within the author's :goal. Characters will not take actions for which they are an :agent if the action does not help them achieve an intention. For actions that exist independently of a character's volition, remove the :agent tag, or add intentions to the character.)
"""
    else:
        error = plan_metadata["log"]

    human_message_prompt = {
        "role": "user",
        "content": human_template.format(
            input_story=story,
            input_problem=problem,
            input_domain=domain,
            input_error=error,
        ),
    }

    chat_prompt = [
        system_message_prompt,
        example_human,
        example_ai,
        human_message_prompt,
    ]

    chat_prompt = clean_whitespace(chat_prompt)

    output, runtime = call_openai(chat_prompt, model_name, temp, 240)
    new_domain, new_problem = parse_for_pddl(output)

    metadata = {
        "model_name": model_name,
        "runtime": f"{runtime:.2}s",
        "temperature": temp,
        "type": "decompose-iteration",
        "prompt": chat_prompt
    }
    
    return new_domain, new_problem, metadata

