from dataclasses import dataclass

@dataclass
class StoryScaffold:
    domain: str
    problem: str
    solution: str
    story: str = None
    conditions_prompt: str = None
    error: str = None


