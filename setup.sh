#!/bin/bash
# Create initial directory structure for CyberPatriot Training Program

# Define the root directory for CyberPatriot content
CYBERPATRIOT_ROOT="CyberPatriot"

# Create main directory and navigate into it
mkdir -p "$CYBERPATRIOT_ROOT"
cd "$CYBERPATRIOT_ROOT" || exit 1 # Exit if cd fails

# Create README and other main files
echo "Creating main documentation files..."
touch README.md
touch CONTRIBUTING.md
touch LICENSE

# Create platform directories and subdirectories
echo "Creating Windows directories..."
mkdir -p Windows/{Guides/{Basic,Intermediate,Advanced},Exercises,Scripts/{Templates,Examples,Solutions},Quizzes/{Quiz-Files,Solutions}}

echo "Creating Linux directories..."
mkdir -p Linux/{Guides/{Basic,Intermediate,Advanced},Exercises,Scripts/{Templates,Examples,Solutions},Quizzes/{Quiz-Files,Solutions}}

echo "Creating Cisco directories..."
mkdir -p Cisco/{Guides/{Basic,Intermediate,Advanced},Exercises,PacketTracer/{Scenarios,Solutions},Scripts/{Templates,Examples},Quizzes/{Quiz-Files,Solutions}}

# Create additional core directories
echo "Creating additional core directories..."
mkdir -p Checklists/{Windows,Linux,Cisco}
mkdir -p Curriculum
mkdir -p VM-Setup/{Windows,Linux,Cisco} # Centralized VM setup location
mkdir -p Resources/{Templates,References,Tools}
mkdir -p Exercises # Top-level for general/cross-platform exercises
mkdir -p Quizzes/{Quiz-Files,Solutions} # Top-level for general/cross-platform quizzes
mkdir -p Team_Resources
mkdir -p Meld
mkdir -p Sponsorships

# Create placeholder README files in each created directory (excluding hidden ones)
echo "Creating placeholder README files..."
find . -type d -not -path '*/\.*' -exec touch {}/README.md \;

# Create initial Week1 curriculum folder as an example
mkdir -p Curriculum/Week01 # Use two digits for consistent sorting
touch Curriculum/Week01/README.md

echo "Directory structure created successfully within '$CYBERPATRIOT_ROOT'!"
echo "Next steps:"
echo "1. Populate the main README.md with the overall project description."
echo "2. Populate CONTRIBUTING.md with contribution guidelines."
echo "3. Add the appropriate LICENSE text to the LICENSE file (e.g., MIT)."
echo "4. Populate the README.md file in each subdirectory."
echo "5. Begin adding unique training materials, exercises, scripts, and quizzes."

cd .. # Return to the parent directory
