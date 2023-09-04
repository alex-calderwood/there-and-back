# "There and Back Again" Results

## Overview
This repository contains additional results from the paper "There and Back Again:
Extracting Formal Domains for Controllable Neurosymbolic Story Authoring" by Jack Kelly, Alex Calderwood, Noah Wardrip-Fruin, and Michael Mateas.

Our system uses GPT-4 to extract logical story domains and problems from input stories for use in the Glaive narrative planner ("Decompose"). It then uses these logical story specifications and the subsequent Glaive plans to generate potential stories ("Compose"). See the paper for more details.

To evaluate this system, we ran the Decompose and Compose pipelines on 100 short stories sampled from the _TinyStories_ and _r/WritingPrompts_ datasets. First, we test each story with both GPT-3.5 and GPT-4, and with and without an auto-debugging step. If the output can successfully generate a Glaive plan, we use Compose to create two stories from the output, one using the problem and domain (pd, without-plan) and another one additionally using the plan (pdp, with-plan).

We've provided the results of these experiments in this repository; we hope they can add additional context and support to the discussion in the paper. 

## Contents

### Pipeline runs
Pipeline runs for each of the 200 total stories are available in the `runs` folder. The top-level directories specify the dataset and model. Each story folder contains the generated domains, problems, and plan for both the original and the auto-debug ("revised") runs. Additionally, the input story is provided, as is metadata that includes the full set of prompt messages (system, assistant, and user) used at each step of the pipeline. 

**_NOTE:_**  Please be aware that some of the stories sampled from the _r/WritingPrompts_ dataset contain graphic and problematic content. We regret that we did not screen it more thoroughly before we ran these experiments.

### Statistics 

Additionally, we computed two sets of statistics over each set of runs. First, we computed the compile rate and plan rate. Second, we computed various descriptive stats about the generated domains and problems, e.g., the average number of predicates and the average number of actions. These are available in the `stats` folder.

### Thematic Analysis

To get a holistic sense of how valuable this system would be in a creative tool, we additionally performed thematic analysis over a small sample of the successful results. The outputs we reviewed are reproduced in the `thematic_analysis` folder.

### System Prompts

While our full prompts are dynamically generated at runtime, the static system prompts are available in the `prompts` folder. Note that examples of full prompts can be found in each run's `metadata.json` file.

## Contact Us

We intend to release an interactive demo and the full source code soon as part of our follow-up work. For now, if you have any questions, feel free to email us at jochkell [at] ucsc [dot] edu or alexcwd [at] ucsc [dot] edu. We're happy to talk more about the paper, our results, and our implementation.

