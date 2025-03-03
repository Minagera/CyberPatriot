#!/bin/bash
# Create initial directory structure for CyberPatriot Training Program

# Create main directories
mkdir -p CyberPatriot
cd CyberPatriot

# Create README and other main files
echo "Creating main documentation files..."
touch README.md
touch CONTRIBUTING.md
touch LICENSE

# Create platform directories and subdirectories
echo "Creating Windows directories..."
mkdir -p Windows/{Guides/{Basic,Intermediate,Advanced},Exercises,Scripts/{Templates,Examples,Solutions},Quizzes/{Quiz-Files,Solutions},VM-Setup}

echo "Creating Linux directories..."
mkdir -p Linux/{Guides/{Basic,Intermediate,Advanced},Exercises,Scripts/{Templates,Examples,Solutions},Quizzes/{Quiz-Files,Solutions},VM-Setup}

echo "Creating Cisco directories..."
mkdir -p Cisco/{Guides/{Basic,Intermediate,Advanced},Exercises,PacketTracer/{Scenarios,Solutions},Scripts/{Templates,Examples},Quizzes/{Quiz-Files,Solutions},Setup}

# Create additional directories
echo "Creating additional directories..."
mkdir -p Checklists/{Windows,Linux,Cisco}
mkdir -p Curriculum
mkdir -p VM-Setup/{Windows,Linux}
mkdir -p Resources/{Templates,References,Tools}

# Create placeholder README files in each directory
echo "Creating placeholder README files..."
find . -type d -not -path "*/\.*" -exec touch {}/README.md \;

# Create initial Week1 curriculum folder
mkdir -p Curriculum/Week1
touch Curriculum/Week1/README.md

echo "Directory structure created successfully!"
echo "Next steps:"
echo "1. Copy README.md content into the main README.md file"
echo "2. Copy CONTRIBUTING.md content into the main CONTRIBUTING.md file"
echo "3. Add an appropriate LICENSE file"
echo "4. Begin adding training materials to the directories"
