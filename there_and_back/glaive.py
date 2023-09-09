import subprocess, os, re
from textwrap import dedent
from pprint import pprint

DOMAIN_PATH     = './there_and_back/temp_files/domain.pddl'
PROBLEM_PATH    = './there_and_back/temp_files/problem.pddl'
SPACE_PATH      = './there_and_back/temp_files/space.pddl'
SOLUTION_PATH   = './there_and_back/temp_files/solution.pddl'

GLAIVE          = "./there_and_back/glaive/Glaive/glaive.jar"


def plan(domain, problem, max_plans=1, timeout_ms=10000):
    _make_space(domain, problem)
    solutions_generator = _solve(max_plans, timeout_ms)
    return solutions_generator


def _make_space(domain, problem):
    with open(DOMAIN_PATH, 'w') as f:
        f.write(domain)

    with open(PROBLEM_PATH, 'w') as f:
        f.write(problem)
    
    output = subprocess.run(
        ['java', '-jar', GLAIVE, '-s', '-d', DOMAIN_PATH, '-p', PROBLEM_PATH, '-ws', SPACE_PATH], 
        stdout=subprocess.DEVNULL,
        stderr=subprocess.STDOUT
    )

    if output.returncode != 0:
        print(f"Error {output.returncode} generating space", output.stdout)

    with open(SPACE_PATH, 'r') as f:
        space = f.read()
    return space


def _solve(max_plans, timeout_ms):
    n = 1
    run = True
    while run:
        # if SOLUTION_PATH exists, delete it
        if os.path.exists(SOLUTION_PATH):
                os.remove(SOLUTION_PATH)
        # Run Glaive
        cmd = ['java', '-jar', GLAIVE, # '-cpocl', 
            '-d',  DOMAIN_PATH, '-p', PROBLEM_PATH, 
            '-rs', SPACE_PATH, '-o', SOLUTION_PATH, 
            '-n', str(n), "-tl", str(timeout_ms)
        ]

        try:
            output = subprocess.check_output(
                cmd, stderr=subprocess.STDOUT, # shell=True,
                #universal_newlines=True
                )
        except subprocess.CalledProcessError as exc:
            print("Status : FAIL", exc.returncode, exc.output)
            output = exc.output
        print(" ".join(cmd))
        if output is not None:
            output = output.decode("utf-8") 
        print(output)

        compiled = "[State Space:" in output
        
        # Yield the solution if it exists
        if os.path.exists(SOLUTION_PATH):
            with open(SOLUTION_PATH, 'r') as f:
                soln = f.read()
            n += 1

            yield {"solution": soln,
                   "steps": parse_plan(soln),
                   "log": output, 
                   "planned": "A solution was found" in output,
                   "compiled": compiled
                }
        else: 
            run = False
            yield {"solution": None, "log": output, "planned": False, "compiled": compiled} # make sure we return if the search times out
        if n > max_plans:
            run = False


def parse_plan(plan):
    # regular expression pattern
    pattern = r":steps(.*?)"
    # extract the steps section
    match = re.search(pattern, plan, re.DOTALL)
    if match:
        steps_section = match.group(1)
        return dedent(steps_section.strip())
    else:
        return plan


def parse_plan_ordered(plan):
    # regular expression pattern
    pattern = r":steps(.*?)\(:orderings"

    # extract the steps section
    match = re.search(pattern, plan, re.DOTALL)
    if match:
        steps_section = match.group(1)
        return dedent(steps_section.strip())
    else:
        return plan


def run_glaive(domain, problem):
    try:
        result = next(plan(domain, problem))  # keys: solution, log, success
        result["reran_with_edit"] = False
        return result

    except Exception as e:
        return {
            "compiled": False,
            "planned": False,
            "reran_with_edit": False,
            "solution": None,
            "log": str(e),
        }
