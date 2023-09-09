import os
import pathlib
from datetime import datetime
import traceback
import json
import sys

from time import sleep

from there_and_back.compose import compose_pd, compose_pdp
from there_and_back.decompose import decompose
from there_and_back.fix_decompose import fix_decompose
from there_and_back.glaive import run_glaive

model = "gpt-4"

def get_domain_file(test_folder, run_name):
    return os.path.join(test_folder, run_name + "-domain.pddl")

def get_problem_file(test_folder, run_name):
    return os.path.join(test_folder, run_name + "-problem.pddl")

def get_solution_file(test_folder, run_name):
    return os.path.join(test_folder, run_name + "-solution.pddl")


def generate_result(input_path, output_dir):

    result_folder = output_dir
    pathlib.Path(result_folder).mkdir(parents=True, exist_ok=True)
    copy_path = os.path.join(result_folder, "input.txt")

    with open(input_path, "r") as file:
        body = file.read()
        with open(copy_path, "w") as copy:
            copy.write(body)
    try:
        run_decompose(result_folder)  # will write a metadata object we can read
        run_compose(result_folder, force_run=False)  # Only runs if there are successful plans
    except Exception as e:

        print(f"Error generating for {input_path}")
        print(traceback.format_exc())
        sleep(3)

def run_decompose(result_folder):
    timestamp = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")

    # read the story that we will run through the pipeline
    input_path = os.path.join(result_folder, "input.txt")
    with open(input_path) as file:
        story = file.read()

    domain, problem, decompose_metadata = decompose(story, model_name=model)
    plan_metadata = write_and_plan(result_folder, "original", domain, problem)
    decompose_metadata["plan_metadata"] = plan_metadata
    revised_domain, revised_problem, metadata_revised = fix_decompose(result_folder, domain, problem, plan_metadata, model_name=model)
    revised_plan_metadata = write_and_plan(result_folder, "revised", revised_domain, revised_problem)
    metadata_revised["plan_metadata"] = revised_plan_metadata

    full_metadata = {
        "timestamp": timestamp,
        "original": decompose_metadata,
        "revised": metadata_revised,
    }

    metadata_path = os.path.join(result_folder, "metadata.json")
    with open(metadata_path, "w") as file:
        json.dump(full_metadata, file, indent=4)


def run_compose(results_folder, force_run=True):
    metadata_path = os.path.join(results_folder, "metadata.json")
    try:
        with open(metadata_path) as file:
            metadata = json.load(file)
    except Exception as e:
        print(f"Compose: Error reading metadata for {results_folder}")
        return
    
    if not force_run:
        if not metadata["original"]["plan_metadata"]["planned"] and not metadata["revised"]["plan_metadata"]["planned"]:
            print(f"Compose: No successful plan found for {results_folder}")
            return

    if metadata["original"]["plan_metadata"]["planned"] and not metadata["revised"]["plan_metadata"]["planned"]:
        target = "original"
    else:
        target = "revised"
        
    domain_file = get_domain_file(results_folder, target)
    problem_file = get_problem_file(results_folder, target)
    solution_file = get_solution_file(results_folder, target)

    with open(domain_file, "r") as file:
        domain = file.read()
    with open(problem_file, "r") as file:
        problem = file.read()
    try:
        with open(solution_file, "r") as file:
            solution = file.read()
    except Exception as e:
        solution = None
    
    pdp_story, pdp_metadata = compose_pdp(solution, domain, problem, model_name=model)
    pdp_story_path = os.path.join(results_folder, "pdp.txt")
    with open(pdp_story_path, "w") as file:
        file.write(pdp_story)

    pd_story, pd_metadata = compose_pd(domain, problem, model_name=model)
    pd_story_path = os.path.join(results_folder, "pd.txt")
    with open(pd_story_path, "w") as file:
        file.write(pd_story)

    # add info to the metadata
    compose_metadata = {
        "target": target,
        "pdp": pdp_metadata,
        "pd": pd_metadata,
    }
    metadata["compose"] = compose_metadata
    with open(metadata_path, "w") as file:
        json.dump(metadata, file, indent=4)


def write_and_plan(test_folder, run_name, domain, problem):
    domain_file = get_domain_file(test_folder, run_name)
    problem_file = get_problem_file(test_folder, run_name)
    solution_file = get_solution_file(test_folder, run_name)

    with open(domain_file, "w") as file:
        file.write(domain)
    with open(problem_file, "w") as file:
        file.write(problem)
    glaive_result = run_glaive(domain, problem)
    
    solution = str(glaive_result["solution"]) if glaive_result["planned"] else glaive_result["log"]
    with open(solution_file, "w") as file:
        file.write(solution)

    return glaive_result


if __name__ == "__main__":

    if len(sys.argv) != 3:
        print("Usage: python -m there_and_back.recompose INPUT_FILE OUTPUT_DIR")
        sys.exit(1)

    input_file = sys.argv[1]
    output_dir = sys.argv[2]

    generate_result(input_file, output_dir)


