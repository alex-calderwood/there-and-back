from datetime import datetime
import json
from textwrap import dedent
from time import sleep, time
import openai
import os

# Note: a previous version of this codebase used uppercase tokens
domain_token    = "<|domain|>"
problem_token   = "<|problem|>"
story_token     = "<|story|>"
error_token     = "<|error|>"
plan_token      = "<|plan|>"


def decompose_title(model_name, type):
    return f"{model_name}-{type}"


def clean_whitespace(prompt):
    new = []
    for message in prompt:
        message['content'] = dedent(message['content']).strip()
        new.append(message)
    return new


def call_openai(*args, return_stream=False, **kwargs):
    tries = 0
    backoff = 60
    while tries < 3:
        try:
            if return_stream:
                output = do_call_stream(*args, return_stream=return_stream, **kwargs)
            else:
                output = do_call(*args, return_stream=return_stream, **kwargs)
            print("call_open", output, type(output))
            return output
        except Exception as e:
            print(f"Connection error with {args}, {kwargs}")
            print(e)
            print(f"Retrying in {backoff / 60} min")
            sleep(backoff)
            backoff *= 2
            tries += 1


def do_call_stream(chat_prompt, model_name, temp, timeout=240, print_stream=True, return_stream=False):
    # print a green title with the prompt and model name and temperature
    print("\033[1;32m" + f"Calling model {model_name} {temp}" + "\033[0m")
    print("\033[3;33m", end="")
    response = openai.ChatCompletion.create(
        model=model_name,
        messages=chat_prompt,
        temperature=temp,
        request_timeout=timeout,
        stream=True,
    )
    for chunk in response:
        try:
            delta = chunk['choices'][0]['delta'].get('content', '')
            if print_stream:
                print(delta, end="")
            yield delta
        except Exception as e:
            print(e)
    if print_stream:
        print("\033[0m")


def do_call(chat_prompt, model_name, temp, timeout=240, print_stream=True, return_stream=False):
    # print a green title with the prompt and model name and temperature
    print("\033[1;32m" + f"Calling model {model_name} {temp}" + "\033[0m")
    print("\033[3;33m", end="")
    start_time = time()
    response = openai.ChatCompletion.create(
        model=model_name,
        messages=chat_prompt,
        temperature=temp,
        request_timeout=timeout,
        stream=True,
    )
    output = ""
    for chunk in response:
        try:
            delta = chunk['choices'][0]['delta'].get('content', '')
            output += delta
            if print_stream:
                print(delta, end="")
        except Exception as e:
            print(e)
    if print_stream:
        print("\033[0m")
    end_time = time()

    return output, end_time - start_time