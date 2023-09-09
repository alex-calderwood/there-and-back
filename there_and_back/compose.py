from there_and_back.system_prompts.compose_pd_system import system as pd_system
from there_and_back.system_prompts.compose_pdp_system import system as pdp_system

from there_and_back.one_shot_examples.story_scaffold import StoryScaffold

from there_and_back.one_shot_examples.ark_example import ark_example

from there_and_back.utils import clean_whitespace, call_openai, domain_token, problem_token, story_token, plan_token

temp = 0.9

def get_prompt_template(plan, domain, problem):
    human_template = "Write a story using this PDDL information:"
    if domain is not None:
        human_template += f"\n{domain_token}\n{domain}\n"
    if problem is not None:
        human_template += f"\n{problem_token}\n{problem}\n"
    if plan is not None:
        human_template += f"\n{plan_token}\n{plan}\n" 
    return human_template


def get_response_template(story):
    human_template = f"\n{story_token}\n{story}\n"
    return human_template


def compose_pdp(plan, domain, problem, example_story: StoryScaffold = ark_example, model_name ="gpt-3.5-turbo"):
    system_message_prompt = {"role": "system", "content": pdp_system}

    if example_story is None:
        raise ValueError("must provide training story for 1-shot")
    # PLAN, DOMAIN, PROBLEM -> STORY
    example_prompt = {"role": "user", "content":  get_prompt_template(example_story.solution, example_story.domain, example_story.problem)}
    example_response = {"role": "user", "content":  get_response_template(example_story.story)}
    examples = [example_prompt, example_response]


    human_message_prompt =  {"role": "user", "content":  get_prompt_template(plan, domain, problem)}
    chat_prompt = [system_message_prompt] + examples + [human_message_prompt]
    chat_prompt = clean_whitespace(chat_prompt)
    output, time = call_openai(chat_prompt, model_name, temp)

    cleaned_output = clean_output(output)

    metadata = {
        "model_name": model_name, 
        "runtime": f"{time:.2}s",
        "temperature": temp, 
        "pipeline": "pdp", 
        "type": "compose",
        "prompt": chat_prompt,
    }

    return cleaned_output, metadata

### PD
def compose_pd(domain, problem, example_story: StoryScaffold = ark_example, model_name ="gpt-3.5-turbo"):
    system_message_prompt = {"role": "system", "content": pd_system}

    if example_story is None:
        raise ValueError("must provide training story for 1-shot")
    example_prompt = {"role": "user", "content":  get_prompt_template(None, example_story.domain, example_story.problem)}
    example_response = {"role": "user", "content":  get_response_template(example_story.story)}
    examples = [example_prompt, example_response]

    human_message_prompt =  {"role": "user", "content":  get_prompt_template(None, domain, problem)}
    chat_prompt = [system_message_prompt] + examples + [human_message_prompt]

    chat_prompt = clean_whitespace(chat_prompt)
    output, time = call_openai(chat_prompt, model_name, temp)

    cleaned_output = clean_output(output)
    metadata = {
        "model_name": model_name,
        "runtime": f"{time:.2}s", 
        "temperature": temp, 
        "pipeline": "pd", 
        "type": "compose",
        "prompt": chat_prompt,
    }

    return cleaned_output, metadata


def clean_output(output):
    return output.replace(story_token, "").strip()

