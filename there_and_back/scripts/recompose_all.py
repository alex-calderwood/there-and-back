import os
from there_and_back.recompose import generate_result

data_path = "./there_and_back/input_data/"
results_path = "./there_and_back/results/"

if __name__ == "__main__":

    for i in range(0, 100):

        tiny = f"story_{i:03d}"
        input_path = os.path.join(data_path, "tiny_stories", f"{tiny}.txt")
        output_folder = os.path.join(results_path, "tiny_stories", tiny)

        generate_result(input_path, output_folder)

        wp = f"wp_{i:03d}"
        input_path = os.path.join(data_path, "writing_prompts", f"{wp}.txt")
        output_folder = os.path.join(results_path, "writing_prompts", wp)

        generate_result(input_path, output_folder)




