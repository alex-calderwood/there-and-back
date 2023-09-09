from there_and_back.compose import compose_pd, compose_pdp
from there_and_back.one_shot_examples.ark_example import ark_example
from there_and_back.one_shot_examples.fantasy_example import fantasy_example
from there_and_back.one_shot_examples.space_example import space_example
from there_and_back.one_shot_examples.western_example import western_example
from datetime import datetime
import os, pathlib

def write(path, experiment, output):
    with open(path + f"/{experiment}.txt", "w") as file:
        file.write(output)


# run compose for every pair of baseline stories (one used as one-shot example, the other as input)

def bake_off_composer(base_dir, model_name):
    timestamp = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")

    parent_dir = os.path.join(base_dir, "compose_baseline")

    pathlib.Path(parent_dir).mkdir(parents=True, exist_ok=True)
    
    tests = {
      "space": space_example,
      "ark": ark_example,
      "fantasy": fantasy_example,
      "western": western_example,
    }

    for example_name, example_story in tests.items():
        example_dir = os.path.join(parent_dir, example_name)
        pathlib.Path(example_dir).mkdir(parents=True, exist_ok=True)

        for test_name, test_story in tests.items():
            if example_name == test_name:
                continue

            experiment_name = f"pdp-{example_name}-{test_name}"
            output, _ = compose_pdp(
                test_story.solution, test_story.domain, test_story.problem, 
                example_story=example_story,
                model_name=model_name)
            write(example_dir, experiment_name, output)
            
            experiment_name = f"pd-{example_name}-{test_name}"
            output, _ = compose_pd(
                test_story.domain, test_story.problem, 
                example_story=example_story,
                model_name=model_name)
            write(example_dir, experiment_name, output)

            
if __name__ == "__main__":
    bake_off_composer("./there_and_back/results/", "gpt-4")
        


