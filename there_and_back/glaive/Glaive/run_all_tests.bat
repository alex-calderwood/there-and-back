@echo off

echo.
echo ALADDIN
echo.
java -jar glaive.jar -d tests/aladdin-domain.pddl -p tests/aladdin-problem.pddl -s -ws tests/aladdin-space.pddl
echo.
java -jar glaive.jar -d tests/aladdin-domain.pddl -p tests/aladdin-problem.pddl -rs tests/aladdin-space.pddl -o tests/aladdin-solution.pddl

echo.
echo HEIST
echo.
java -jar glaive.jar -d tests/heist-domain.pddl -p tests/heist-problem.pddl -s -ws tests/heist-space.pddl
echo.
java -jar glaive.jar -d tests/heist-domain.pddl -p tests/heist-problem.pddl -rs tests/heist-space.pddl -o tests/heist-solution.pddl

echo.
echo WESTERN
echo.
java -jar glaive.jar -d tests/western-domain.pddl -p tests/western-problem.pddl -s -ws tests/western-space.pddl
echo.
java -jar glaive.jar -d tests/western-domain.pddl -p tests/western-problem.pddl -rs tests/western-space.pddl -o tests/western-solution.pddl

echo.
echo FANTASY
echo.
java -jar glaive.jar -d tests/fantasy-domain.pddl -p tests/fantasy-problem.pddl -s -ws tests/fantasy-space.pddl
echo.
java -jar glaive.jar -d tests/fantasy-domain.pddl -p tests/fantasy-problem.pddl -rs tests/fantasy-space.pddl -o tests/fantasy-solution.pddl

echo.
echo SPACE
echo.
java -jar glaive.jar -d tests/space-domain.pddl -p tests/space-problem.pddl -s -ws tests/space-space.pddl
echo.
java -jar glaive.jar -d tests/space-domain.pddl -p tests/space-problem.pddl -rs tests/space-space.pddl -o tests/space-solution.pddl

echo.
echo ARK
echo.
java -jar glaive.jar -d tests/ark-domain.pddl -p tests/ark-problem.pddl -s -ws tests/ark-space.pddl
echo.
java -jar glaive.jar -d tests/ark-domain.pddl -p tests/ark-problem.pddl -rs tests/ark-space.pddl -o tests/ark-solution.pddl
echo.
java -jar glaive.jar -d tests/ark-domain.pddl -p tests/ark-problem.pddl -rs tests/ark-space.pddl -pp tests/ark-partial.pddl -o tests/ark-solution-with-partial.pddl

echo.
echo THE BEST LAID PLANS
echo.
java -jar glaive.jar -d tests/blp-domain.pddl -p tests/blp-problem-win.pddl -s -ws tests/blp-win-space.pddl
echo.
java -jar glaive.jar -d tests/blp-domain.pddl -p tests/blp-problem-win.pddl -rs tests/blp-win-space.pddl -o tests/blp-win-solution.pddl
echo.
java -jar glaive.jar -d tests/blp-domain.pddl -p tests/blp-problem-die.pddl -s -ws tests/blp-die-space.pddl
echo.
java -jar glaive.jar -d tests/blp-domain.pddl -p tests/blp-problem-die.pddl -rs tests/blp-die-space.pddl -o tests/blp-die-solution.pddl